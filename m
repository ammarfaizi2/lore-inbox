Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbTLEEcC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 23:32:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbTLEEcC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 23:32:02 -0500
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:10979 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S263060AbTLEEcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 23:32:00 -0500
Message-ID: <3FD00A3B.2030403@backtobasicsmgmt.com>
Date: Thu, 04 Dec 2003 21:31:55 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       =?ISO-8859-1?Q?David_Mart=EDnez_Moreno?= <ender@debian.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       clubinfo.servers@adi.uam.es, Ingo Molnar <mingo@elte.hu>,
       Nathan Scott <nathans@sgi.com>, Mihai RUSU <dizzy@roedu.net>
Subject: Re: Errors and later panics in 2.6.0-test11.
References: <200312031417.18462.ender@debian.org>	<Pine.LNX.4.58.0312030757120.5258@home.osdl.org>	<200312031747.16927.ender@debian.org>	<Pine.LNX.4.58.0312030916080.6950@home.osdl.org>	<20031204124342.GD1086@suse.de>	<20031204140738.GE1086@suse.de> <16335.63095.266710.554162@notabene.cse.unsw.edu.au>
In-Reply-To: <16335.63095.266710.554162@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:

> After staring at the code over and ove again, I finally saw the
> assumption that I was making that was invalid.  I also found a
> possible data-corruption bug in the process.
> 
> If you have been having problems with raid5, please try this patch and
> see if it helps.

Initial indications are good here, my system (using XFS on linear DM 
over a 6-disk RAID-5) just passed a bonnie++ run while the array was 
resyncing, which it has not done without oopsing before.

