Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264426AbTLGNxX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 08:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264428AbTLGNxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 08:53:23 -0500
Received: from out011pub.verizon.net ([206.46.170.135]:60134 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S264426AbTLGNxV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 08:53:21 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
To: Paul P Komkoff Jr <i@stingr.net>, linux-kernel@vger.kernel.org
Subject: Re: amanda vs 2.6
Date: Sun, 7 Dec 2003 08:53:19 -0500
User-Agent: KMail/1.5.1
References: <200311261212.10166.gene.heskett@verizon.net> <200312012141.01223.gene.heskett@verizon.net> <20031207115600.GM30105@stingr.net>
In-Reply-To: <20031207115600.GM30105@stingr.net>
Organization: None that appears to be detectable by casual observers
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312070853.19428.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.10.15] at Sun, 7 Dec 2003 07:53:20 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 07 December 2003 06:56, Paul P Komkoff Jr wrote:
>Replying to Gene Heskett:
>> Formerly rh8.0 with almost all updates, eg if its still an rpm, I
>> let update do it.  Hand built stuffs like cups and sane are newer
>> than 8.0, as is the currently working kde-3.1.1a.  Obviously I
>> don't let up2date anywhere near that stuff.
>
>seems that you have nsswitch problem.

No, or possibly that might be another way around that bush too.  It 
turned out that there was a missing call in my bash install, and the 
bash from fedora had it.  Installing the same bash from fedora fixed 
it all right up.  Compile options difference.

>I encountered same behavior with latest stable gentoo, 2.6 kernel
> and nss_mysql. Upgrade to latest glibc + nptl solved this.

Latest bug/security-fix glibc is installed.  Dunno about nptl, or even 
what that puppy does.

FWIW, my other amanda problem wherein it wouldn't load and search the 
tape magazine it it wasn't already loaded seems to have been fixed by 
adding a define in my configdir/chg-scsi.conf, nameing the 
SCSItapedev = /dev/sg0, where the robot is sg1 at LUN 1, same device 
addr.  Normally the drive is /dev/nst0, but for that query, it has to 
come through /dev/sg0 for some reason.  2.4 kernels didn't have a 
problem with that, 2.6.0-test11 at least did.  And there hadn't been 
any changes to the chg-scsi stuff in amanda since 2001 so that cannot 
be blamed on "newer versionitis". :)

So there are apparently two solutions to the first problem, and at 
least one to the second above.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.

