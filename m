Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129374AbQJ3RTp>; Mon, 30 Oct 2000 12:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129128AbQJ3RTf>; Mon, 30 Oct 2000 12:19:35 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:33555 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129308AbQJ3RT0>;
	Mon, 30 Oct 2000 12:19:26 -0500
Message-ID: <39FDAD99.47FA6A54@mandrakesoft.com>
Date: Mon, 30 Oct 2000 12:19:21 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@caldera.de>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        sct@redhat.com
Subject: Re: [PATCH] kiobuf/rawio fixes for 2.4.0-test10-pre6
In-Reply-To: <20001027222143.A8059@caldera.de> <200010272123.OAA21478@penguin.transmeta.com> <20001030124513.A28667@caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> +Locking down user memory and doing mass storage device IO with it is not
> +the only purpose of kiobufs.  Another use for kiobufs is allowing
> +user-space mmaping dma memory, e.g in sound drivers.  To do so you
> +need to lock-down kernel virtual memory and refernece it using kiobufs.
> +The code that does exactly this is not yet in the kernel - get Stephen
> +Tweedie's kiobuf patchset if you want to use this.

Take a look at drivers/sound/via82cxxx_audio.c.  How can that mmap be
improved by using kiobufs?

It seems like there is less overhead to mmap(2) DMA memory the way I do
it currently -- without kiobufs...

Honestly interested,

	Jeff


-- 
Jeff Garzik             | "Mind if I drive?"  -Sam
Building 1024           | "Not if you don't mind me clawing at the
MandrakeSoft            |  dash and shrieking like a cheerleader."
                        |                     -Max
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
