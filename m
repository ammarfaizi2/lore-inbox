Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752087AbWIXDtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752087AbWIXDtT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 23:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbWIXDtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 23:49:18 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:26210 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752087AbWIXDtP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 23:49:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=n/U8r/1NYqfEJ/KoqyNUKBGVne5zWqoW1w4OyUwWm/QLfxCm9VDj/jb0FaVzGo55nnKQdac70MyokKrxvSaiHRRoKhmbJbow2uW//8ecfRolug9qdbJ9euJM2xenRwP70NMYVbnsx4fl6Ehf0qtLZKLY/y29jFpkt4Elqh6DEDQ=
Message-ID: <489ecd0c0609232049o3dde0fb2pd17087e78f9e1886@mail.gmail.com>
Date: Sun, 24 Sep 2006 11:49:14 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Subject: Re: [PATCH 1/4] Blackfin: arch patch for 2.6.18
Cc: "Mike Frysinger" <vapier.adi@gmail.com>, linux-kernel@vger.kernel.org,
       "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <200609232143.56996.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <489ecd0c0609202032l1c5540f7t980244e30d134ca0@mail.gmail.com>
	 <200609230218.36894.arnd@arndb.de>
	 <8bd0f97a0609222350o3a9c8c36g468a6177ae7b1ea7@mail.gmail.com>
	 <200609232143.56996.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/06, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 23 September 2006 08:50, Mike Frysinger wrote:
> > > There is not much point in trying to use the same numbers as an existing
> > > architecture if that means that you have to leave holes like setup().
> > > I don't know if you still have the choice of completely changing the
> > > syscall numbers, but it would make it nicer in the future.
> >
> > we do, fortunately, have this luxury ... so we can look forward to a
> > nice cleaning of our syscall interface
>
> Actually, I have one more general comment here. It would be really nice
> if you could add those files that have nothing specific to blackfin moved
> to include/asm-generic. That would probably include bug.h, current.h,
> flat.h, hardirq.h, ioctls.h, {ipc,msg,sem,msg}buf.h, kmap_types.h, mman.h,
> param.h, pci.h, poll.h, posix_types.h, scatterlist.h, semaphore.h,
> socket.h, sockios.h, stat.h, termbits.h, termios.h, types.h, and unistd.h.
>
> It doesn't really matter if you're the only user of the new files,
> as long as they are generic enough to be used by every future port.
> If the files are specific to nommu, 32bit or little-endian, then
> they should probably have the respective name so the next person can
> do it differently.
>
> For unistd.h, it may be a good idea to leave space for a few syscall
> numbers specific to architectures, so you could start the generic numbers
> at 32 or so.
>
> Of course nobody is forcing you do do that work, but the next person
> trying to do will be really thankful.
 Yes I agree that there are many arch header files can be put into the
generic folder. We just simplely followed other architectures. But I
will be glad to help doing this work.
>
>        Arnd <><
>


-- 
Best regards,
Luke Yang
luke.adi@gmail.com
