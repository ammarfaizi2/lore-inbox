Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129048AbQJ3Qve>; Mon, 30 Oct 2000 11:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129075AbQJ3QvX>; Mon, 30 Oct 2000 11:51:23 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:60946 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129048AbQJ3QvE>;
	Mon, 30 Oct 2000 11:51:04 -0500
Message-ID: <39FDA69C.92B090A6@mandrakesoft.com>
Date: Mon, 30 Oct 2000 11:49:32 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: John Levon <moz@compsoc.man.ac.uk>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: kmalloc() allocation.
In-Reply-To: <Pine.LNX.3.95.1001030111027.1186A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> Now, I could set up a linked-list of buffers and use vmalloc()
> if the buffers were allocated from non-paged RAM. I don't think
> they are. These buffers must be present during an interrupt.

Non-paged RAM?  I'm not sure what you mean by that.

Both kmalloc and vmalloc allocate pages, but neither will allocate pages
that the system will swap out (page out).  [vk]malloc pages are always
around during an interrupt.

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
