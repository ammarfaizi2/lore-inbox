Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbUL1OHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbUL1OHN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 09:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbUL1OHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 09:07:13 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:58108 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S261233AbUL1OHD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 09:07:03 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: unkillable processes using samba, xfs and lvm2 snapshots (k 2.6.10)
Date: Tue, 28 Dec 2004 09:07:01 -0500
User-Agent: KMail/1.7
Cc: Gildas LE NADAN <gildas.le-nadan@inha.fr>
References: <41D14251.4030704@inha.fr>
In-Reply-To: <41D14251.4030704@inha.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412280907.01681.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [151.205.45.252] at Tue, 28 Dec 2004 08:07:02 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 December 2004 06:24, Gildas LE NADAN wrote:
>Hi,
>
>I experience hangs on samba processes on a filer using xfs over lvm2
> as data partitions, when there is active snapshots of the xfs
> partitions.
>
>I have a clone of the production server (same software, same
> hardware) where the situation can be reproduced perfectly.
>
>Testings showed that the result was the same, whether the snapshots
> were mounted or not : smbd processes are locked and unkillable
> while the machine is normaly working otherwise, except software
> reboot is impossible and hardware reset is needed.
>
>I noticed Brad Fitzpatrick's case in kernel 2.6.10 changelog
>(http://lkml.org/lkml/2004/11/14/98) and tested kernel 2.6.10 today
>without success.
>
>Configuration is the following :
>- supermicro m/b with dual Xeon 2,8Ghz (SMT is active)
>- 1 GB ram,
>- adaptec u320 raid controler
>- kernel 2.6.10
>- debian sarge
>- samba 3
>- LVM2
>- XFS with quota turned on
>
>All software are from debian sarge packages, except the kernel.
>
>I'm not able to determine if the problem is more xfs, device mapper
> or samba related, and was not able to do extensive testings (using
> a different filesystem, testing with a different daemon, etc...),
> but SMT/SMP testings showed that this is not a SMP/SMT related
> problem.
>
>I've compiled the kernel with the debugging options, so I might
> provide additional informations if needed as in Brad's case.
>
>Sincerely,
>Gildas LE NADAN
>(Please CC me as I didn't suscribe to LKML)

I have a somewhat similar case here, samba processses are unkillable, 
but I can do a software reboot. Something is also killing amandad, 
and I lost the backup of this machine last night.  The amanda logs 
are bereft of any info and I've no clue that its happened except a 
message from amanda that the client access timed out on this machine.
This was while running 2.6.10-rc3-mm1-V0.33-04 which ran stably for 8 
days previously.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.30% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
