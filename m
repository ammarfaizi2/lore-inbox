Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131786AbQLPMBg>; Sat, 16 Dec 2000 07:01:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131790AbQLPMB0>; Sat, 16 Dec 2000 07:01:26 -0500
Received: from mail.cendio.se ([193.180.23.52]:56078 "EHLO ementhal.cendio.se")
	by vger.kernel.org with ESMTP id <S131786AbQLPMBU>;
	Sat, 16 Dec 2000 07:01:20 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Linus's include file strategy redux
In-Reply-To: <91bnoc$vij$2@enterprise.cistron.net> <E146iof-0000OI-00@the-village.bc.nu>
From: Marcus Sundberg <marcus@cendio.se>
Date: 16 Dec 2000 12:30:52 +0100
In-Reply-To: alan@lxorguk.ukuu.org.uk's message of "Fri, 15 Dec 2000 00:33:39 +0000 (GMT)"
Message-ID: <ve7l50iowj.fsf@biffen.cendio.se>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alan@lxorguk.ukuu.org.uk (Alan Cox) writes:

> > >Which works because in a normal compile environment they have /usr/include
> > >in their include path and /usr/include/linux points to the directory
> > >under /usr/src/linux/include.
> > 
> > No, that a redhat-ism.
> 
> Umm, its a most people except Debianism. People relied on it despite it
> being wrong. RH7 ships with a matching library set of headers. I got to close
> a lot of bug reports explaining to people that the new setup was in fact
> right 8(

Fine, now if all distributions could also put something like:
#ifdef __KERNEL__
# error To build kernel modules you must point the compiler to
# error headers matching your current kernel!
#endif
in /usr/include/linux/module.h 3:d party kernel module developers
would be saved a lot of silly "bug" reports, and everybody would
be happy.

//Marcus
-- 
-------------------------------+-----------------------------------
        Marcus Sundberg        |       Phone: +46 707 452062
  Embedded Systems Consultant  |      Email: marcus@cendio.se
       Cendio Systems AB       |       http://www.cendio.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
