Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268703AbUJKHH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268703AbUJKHH2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 03:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268713AbUJKHH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 03:07:28 -0400
Received: from out004pub.verizon.net ([206.46.170.142]:17600 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S268703AbUJKHHZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 03:07:25 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9-rc4 - pls test (and no more patches)
Date: Mon, 11 Oct 2004 03:07:18 -0400
User-Agent: KMail/1.7
Cc: Linus Torvalds <torvalds@osdl.org>
References: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410102016180.3897@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410110307.18553.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [151.205.61.134] at Mon, 11 Oct 2004 02:07:22 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 October 2004 23:22, Linus Torvalds wrote:
>Ok,
> trying to make ready for the real 2.6.9 in a week or so, so please
> give this a beating, and if you have pending patches, please hold
> on to them for a bit longer, until after the 2.6.9 release. It
> would be good to have a 2.6.9 that doesn't need a dot-release
> immediately ;)
>
>The appended shortlog gives a pretty good idea of what has been
> going on. Mostly small stuff, with some architecture updates and an
> ACPI update thrown in for good measure.
>
>(The ACPI update fixes broken AML with implied returns, and in
> particular the Compaq Evo notebook fan control. Yay! Guess who has
> one..)
>
>  Linus
>
I'm running it, and dl'ing the suse livecd-9.1 to test the burning 
sometime tomorrow.  About the only unusual thing I see in dmesg is:
-----------------
EXT3 FS on hda8, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
EXT3-fs warning: maximal mount count reached, running e2fsck is 
recommended
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdd2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
EXT3-fs warning: maximal mount count reached, running e2fsck is 
recommended
kjournald starting.  Commit interval 5 seconds
-----------------
but it *didn't* ask me to hit y for the check while it was booting.

Also, the last couple of -rc's seem to be keeping a lock on /usr when 
shutting down, so the 3 attempts at a clean umount during the 
shutdown phase all fail.  I made sure that everything was stopped 
except some screen backgrounds that come from /usr, and gkrellm, 
which sits on every window here.  That hasn't bothered the reboots 
until maybe -rc2 but -rc3 for sure is doing it 100% of the time in 
the shutdown phase.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
