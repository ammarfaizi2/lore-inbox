Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129069AbQKPUjn>; Thu, 16 Nov 2000 15:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131392AbQKPUjX>; Thu, 16 Nov 2000 15:39:23 -0500
Received: from mhaaksma-3.dsl.speakeasy.net ([64.81.17.226]:30728 "EHLO
	mail.neruo.com") by vger.kernel.org with ESMTP id <S129069AbQKPUjS>;
	Thu, 16 Nov 2000 15:39:18 -0500
Subject: Re: APM oops with Dell 5000e laptop
From: Brad Douglas <brad@neruo.com>
To: Dax Kelson <dax@gurulabs.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.30.0011161054420.16124-100000@ultra1.inconnect.com>
Content-Type: text/plain
X-Mailer: Evolution 0.6 (Developer Preview)
Date: 17 Nov 2000 04:08:55 +0800
Mime-Version: 1.0
Message-Id: <20001116203922Z129069-521+734@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Alan Cox said once upon a time (Thu, 16 Nov 2000):
> 
> > > I just got a Sceptre 6950 (also known as a Dell 5000e), I just installed
> > > Red Hat 7.0 on it, and got an APM related oops at boot.
> >
> > Yep. This is not a Linux problem
> 
> The kernel works around/ignores/disables other broken hardware or broken
> features of otherwise working hardware with black lists.  There will be
> many *many* of these laptops sold.

Unlike other BIOS, this cannot be fixed up and I don't believe there is an easy way to identify every single "version" of this machine (Stephen Rothwell, can you comment here?).
That broken call is a major part of the Linux APM system.  The simplest (and arguably, best) solution is to just not compile it into the kernel or add "apm=off" to lilo.conf until the problem is fixed.

> Is there a way to uniquely identify the affected BIOSes at boot time and
> turn off APM?  According to Brad Douglas, the 32-bit Get Power Status
> (0AH) call is broken.

I do not believe so.  I tend to think that detecting these broken models is a waste of kernel code (especially, if there's an effort to correct the problem).

> Supposedly there will be a BIOS update in the "future" to correct this
> problem.

This is what we have been led to believe.  I have no ETA at this time.

Brad Douglas
brad@neruo.com
brad@tuxtops.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
