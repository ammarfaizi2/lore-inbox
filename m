Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132859AbRECTYM>; Thu, 3 May 2001 15:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132853AbRECTYC>; Thu, 3 May 2001 15:24:02 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:7428 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S132801AbRECTX6>;
	Thu, 3 May 2001 15:23:58 -0400
Date: Tue, 1 May 2001 20:16:08 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Igor Bukanov <boukanov@fi.uib.no>, linux-kernel@vger.kernel.org
Subject: Re: Can eject mounted zip disk after suspend/resume (2.4.4)
Message-ID: <20010501201606.A32@(none)>
In-Reply-To: <3AEE05AE.1090101@fi.uib.no> <E14uOJr-0000pC-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E14uOJr-0000pC-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, May 01, 2001 at 01:47:08AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If I hit an eject button on internal IDE IOMEGA zip drive after 
> > resume/suspend to memory on my Dell Inspiron 7500 notebook, then the 
> > disk will be ejected even if it is mounted. This behavior happens ONLY 
> > if I suspend my system with the mounted zip. Could I fix this somehow?
> 
> Its an Inspiron bios bug - they fail to preserve the locked stat of the zip
> drive across a suspend. Its not the worst bug in the world. In theory the
> scsi/ide layer could use a PM notifier to check the locked stat is right
> and force the drive into the right state. I'd take patches for it but lets
> say its not high on my 'urgent problem' list

That would not work. If someone pressed eject while resuming....

[Fact that zips like to remember button presses might make this pretty
bad.]

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

