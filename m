Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129408AbQJ3SSP>; Mon, 30 Oct 2000 13:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129466AbQJ3SSF>; Mon, 30 Oct 2000 13:18:05 -0500
Received: from ns.caldera.de ([212.34.180.1]:40453 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129408AbQJ3SRy>;
	Mon, 30 Oct 2000 13:17:54 -0500
Date: Mon, 30 Oct 2000 19:17:12 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        sct@redhat.com
Subject: Re: [PATCH] kiobuf/rawio fixes for 2.4.0-test10-pre6
Message-ID: <20001030191712.B27664@caldera.de>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, sct@redhat.com
In-Reply-To: <20001027222143.A8059@caldera.de> <200010272123.OAA21478@penguin.transmeta.com> <20001030124513.A28667@caldera.de> <39FDAD99.47FA6A54@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <39FDAD99.47FA6A54@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Oct 30, 2000 at 12:19:21PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 12:19:21PM -0500, Jeff Garzik wrote:
> Christoph Hellwig wrote:
> > +Locking down user memory and doing mass storage device IO with it is not
> > +the only purpose of kiobufs.  Another use for kiobufs is allowing
> > +user-space mmaping dma memory, e.g in sound drivers.  To do so you
> > +need to lock-down kernel virtual memory and refernece it using kiobufs.
> > +The code that does exactly this is not yet in the kernel - get Stephen
> > +Tweedie's kiobuf patchset if you want to use this.
> 
> Take a look at drivers/sound/via82cxxx_audio.c.  How can that mmap be
> improved by using kiobufs?

I think so - but you need Stephen's kvmap patch, that is in the same
patchset the forward-ported fixes are
(at ftp://ftp.linux.org.uk/pub/linux/sct/fs/raw-io/)

An very nice example is included.

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
