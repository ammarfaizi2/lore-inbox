Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268834AbTBZRmJ>; Wed, 26 Feb 2003 12:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268844AbTBZRmJ>; Wed, 26 Feb 2003 12:42:09 -0500
Received: from franka.aracnet.com ([216.99.193.44]:62634 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S268834AbTBZRmI>; Wed, 26 Feb 2003 12:42:08 -0500
Date: Wed, 26 Feb 2003 09:52:13 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave McCracken <dmccr@us.ibm.com>, Andrew Morton <akpm@digeo.com>
cc: zilvinas@gemtek.lt, helgehaf@aitel.hist.no, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH 2.5.62-mm3] objrmap fix for X
Message-ID: <14910000.1046281932@[10.10.2.4]>
In-Reply-To: <40780000.1046240068@[10.10.2.4]>
References: <20030223230023.365782f3.akpm@digeo.com>
 <3E5A0F8D.4010202@aitel.hist.no><20030224121601.2c998cc5.akpm@digeo.com>
 <20030225094526.GA18857@gemtek.lt><20030225015537.4062825b.akpm@digeo.com>
 <131360000.1046195828@[10.1.1.5]><20030225132755.241e85ac.akpm@digeo.com>
 <359700000.1046209586@[10.1.1.5]><453440000.1046214174@[10.1.1.5]>
 <40780000.1046240068@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> It occurred to me I'm already using (abusing?) the flag for nonlinear
>>> pages, so I have to keep it.  I'll chase solutions for X.
>> 
>> Ok, the vm_ops->nopage function is set in drivers like drm and agp.  I
>> don't think it's reasonable to require all of them to set PageAnon.  So
>> here's a patch that tests the page on do_no_page and sets the flag
>> appropriately.
> 
> Well, it runs fine, but I get truly freaky performance results. My machine
> might have gone wacko on me or something - the patch seems perfectly
> simple to me. Kernbench is all over the map - user and elapsed way up,
> system is down. Ummm .. probably all too strange to be true, and I've
> made a mistake, but if some more sane person than I could run a quick
> test, would help.

Pah. Debian stealth-upgraded me to gcc 3.2 ... no wonder it's slow as a
dog. So your patch is stable, and works just fine. Sorry,

M.

