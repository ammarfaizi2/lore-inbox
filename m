Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263879AbTLEDtV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 22:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263880AbTLEDtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 22:49:21 -0500
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:5347 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S263879AbTLEDtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 22:49:20 -0500
Message-ID: <3FD00034.1000006@backtobasicsmgmt.com>
Date: Thu, 04 Dec 2003 20:49:08 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: Linus Torvalds <torvalds@osdl.org>, Jens Axboe <axboe@suse.de>,
       =?ISO-8859-1?Q?David_Mart=EDnez_Moreno?= <ender@debian.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       clubinfo.servers@adi.uam.es, Ingo Molnar <mingo@elte.hu>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Errors and later panics in 2.6.0-test11.
References: <200312031417.18462.ender@debian.org> <Pine.LNX.4.58.0312030757120.5258@home.osdl.org> <20031203162045.GA27964@suse.de> <Pine.LNX.4.58.0312030823010.5258@home.osdl.org> <3FCE1C87.2050006@backtobasicsmgmt.com> <20031205032023.GB1693@frodo>
In-Reply-To: <20031205032023.GB1693@frodo>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott wrote:

>>The problem I reported was also with RAID-5, and I have also found a 
>>problem similar to Nathan's (probably the same one) by just trying to 
>>run bonnie++ on an XFS filesystem on DM over RAID-5, even after 
>>formatting the XFS filesystem to forcibly align everything to RAID-5 
>>stripes (64K units).
> 
> 
> FWIW, this doesn't align _everything_ (space allocations done
> through the XFS allocator are influenced, which means "most")
> -- log IO is still going to be sector aligned, as are any IOs
> to the four XFS allocation group header metadata structures.

OK, I thought that "-l sunit=..." being set to a block-size multiple 
would take care of that as well, but apparently not.

