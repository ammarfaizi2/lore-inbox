Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265107AbTLCRZp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 12:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265110AbTLCRZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 12:25:45 -0500
Received: from wsip-68-14-236-254.ph.ph.cox.net ([68.14.236.254]:48585 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S265107AbTLCRZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 12:25:43 -0500
Message-ID: <3FCE1C87.2050006@backtobasicsmgmt.com>
Date: Wed, 03 Dec 2003 10:25:27 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Jens Axboe <axboe@suse.de>,
       =?ISO-8859-1?Q?David_Mart=EDnez_Moren?= =?ISO-8859-1?Q?o?= 
	<ender@debian.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       clubinfo.servers@adi.uam.es, Ingo Molnar <mingo@elte.hu>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Errors and later panics in 2.6.0-test11.
References: <200312031417.18462.ender@debian.org> <Pine.LNX.4.58.0312030757120.5258@home.osdl.org> <20031203162045.GA27964@suse.de> <Pine.LNX.4.58.0312030823010.5258@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312030823010.5258@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> The ones I've seen seem to be raid-0, but Nathan (nathans@sgi.com)
> reported problems in RAID-5 under load. I didn't decode the full oops on
> that one, but it really looked like a stale "bi" bio that trapped on the
> PAGE_ALLOC debug code.

The problem I reported was also with RAID-5, and I have also found a 
problem similar to Nathan's (probably the same one) by just trying to 
run bonnie++ on an XFS filesystem on DM over RAID-5, even after 
formatting the XFS filesystem to forcibly align everything to RAID-5 
stripes (64K units).

