Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129891AbQJ3Xky>; Mon, 30 Oct 2000 18:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129887AbQJ3Xko>; Mon, 30 Oct 2000 18:40:44 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:65293 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129517AbQJ3Xk1>;
	Mon, 30 Oct 2000 18:40:27 -0500
Message-ID: <39FE06C7.485467DF@mandrakesoft.com>
Date: Mon, 30 Oct 2000 18:39:51 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: "H. Peter Anvin" <hpa@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: / on ramfs, possible?
In-Reply-To: <Pine.LNX.4.21.0010302329140.16675-100000@imladris.demon.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> 
> On Mon, 30 Oct 2000, H. Peter Anvin wrote:
> 
> > Pardon?!  This doesn't make any sense...
> >
> > The question was: how do switch from the initrd to using the ramfs as /?
> > Using pivot_root should do it (after the pivot, you can of course nuke
> > the initrd ramdisk.)
> 
> My question is: What do you want to do that for? You can nuke the initrd
> ramdisk, but you can't drop the rd.c code, or ll_rw_blk.c code, etc. So
> why not just keep your root filesystem in the initrd where it started off?

ramfs size is far more dynamic than rd, and it shrinks as well as grows.

Unless you are creating a lot of temporary files and such, though,
initrd is indeed a much better solution from many perspectives. (IMHO)

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
