Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbSLFL3L>; Fri, 6 Dec 2002 06:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262214AbSLFL3L>; Fri, 6 Dec 2002 06:29:11 -0500
Received: from packet.digeo.com ([12.110.80.53]:60336 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262190AbSLFL3K>;
	Fri, 6 Dec 2002 06:29:10 -0500
Message-ID: <3DF08BC7.62436532@digeo.com>
Date: Fri, 06 Dec 2002 03:36:39 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH 2.4.20-aa1] Readlatency-2
References: <200212061038.27387.m.c.p@wolk-project.de> <200212062045.25377.conman@kolivas.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Dec 2002 11:36:39.0619 (UTC) FILETIME=[BDF17130:01C29D1B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> 
> io_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.4.20 [5]              203.4   33      40      15      3.07
> 2.4.20aa1 [3]           238.3   27      46      15      3.60
> 2.4.20aa1rl2 [3]        302.5   22      63      16      4.57

Something must have gone wrong here.  rl2 cannot be worse than
2.4.20 in this test.

Umm, quick sanity check:

2.4.20-rl2      321.44  147%    96      24%
2.4.20          361.70  130%    108     24%

So only a 10% speedup, but certainly not a 50% slowdown.  (That is
on scsi).

Maybe a patch preparation problem?
