Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266938AbRG1Qpq>; Sat, 28 Jul 2001 12:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266941AbRG1Qpe>; Sat, 28 Jul 2001 12:45:34 -0400
Received: from ns.caldera.de ([212.34.180.1]:45719 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S266938AbRG1QpY>;
	Sat, 28 Jul 2001 12:45:24 -0400
Date: Sat, 28 Jul 2001 18:45:10 +0200
Message-Id: <200107281645.f6SGjA620666@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: kiwiunixman@yahoo.co.nz (Matthew Gardiner)
Cc: kernel <linux-kernel@vger.kernel.org>, Hans Reiser <reiser@namesys.com>,
        Joshua Schmidlkofer <menion@srci.iwpsd.org>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <01072901450000.02683@kiwiunixman.nodomain.nowhere>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hi Matthew,

In article <01072901450000.02683@kiwiunixman.nodomain.nowhere> you wrote:
> Regards to the ReiserFS. Something more spookie, OpenLinux (no boos and 
> hisses please ;) ), they have ReiserFS as a module, yet, when I have the root 
> partition as reiser I have no problems, voo doo magic perhaps? because when I 
> compiled 2.4.7 w/ ReiserFS as a module, the boot forks up.

Well, as reiserfs is a module it needs to be on the initrd.  The install
of the kernel kernel RPM automatically creates a new initrd which includes
the modules in /etc/modules/rootfs.  If you don't create a new initrd your
modular reiserfs setup will of course fail.

> Regarding the last comment, I think Redhat and Caldera have debugging enable 
> (God knows why?), well, Caldera definately dones, after having a look at 
> their default kernel configuration, hence, when I recompiled my kernel to 
> 2.4.7, threw the reiserFS into the guts of the kernel with debugging turned 
> off, there was a speed increase.

Reiserfs as implemented in the 2.4.2-based kernel of OpenLinux 3.1 is
everything but stable and has a lot of issues (e.g. NFS-exporting doesn't
work).  That is the reason why it is a) marked experimental and is completly
unsupported (and that is written _big_ _fat_ in manuals and similar stuff)
and b) has debugging enabled to have the additional sanity checks that are
under this option and give addtional hints if reiserfs fails again.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
