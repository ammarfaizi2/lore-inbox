Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWGKJPK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWGKJPK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 05:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbWGKJPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 05:15:10 -0400
Received: from main.gmane.org ([80.91.229.2]:16601 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750780AbWGKJPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 05:15:08 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Petr Vyskocil <petr@anime.cz>
Subject: Re: Kernel 2.6.17 and RAID5 Grow Problem (critical section backup)
Date: Tue, 11 Jul 2006 11:05:59 +0200
Message-ID: <e8vplt$fgv$1@sea.gmane.org>
References: <Pine.LNX.4.64.0607070830450.2648@p34.internal.lan> <Pine.LNX.4.64.0607070845280.2648@p34.internal.lan> <Pine.LNX.4.64.0607070849140.3010@p34.internal.lan> <Pine.LNX.4.64.0607071037190.5153@p34.internal.lan> <17582.55703.209583.446356@cse.unsw.edu.au> <Pine.LNX.4.64.0607101747160.2603@p34.internal.lan> <Pine.LNX.4.61.0607110026030.5420@yvahk01.tjqt.qr> <Pine.LNX.4.64.0607101830130.2603@p34.internal.lan> <Pine.LNX.4.61.0607110950450.30961@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 81.30.238.40
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
In-Reply-To: <Pine.LNX.4.61.0607110950450.30961@yvahk01.tjqt.qr>
Cc: linux-raid@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Hm, what's superblock 0.91? It is not mentioned in mdadm.8.
>>>
>> Not sure, the block version perhaps?
>>
> Well yes of course, but what characteristics? The manual only lists
>  0, 0.90, default
>  1, 1.0, 1.1, 1.2
> No 0.91 :(


AFAICR superblock version gets raised by 0.01 for the duration of 
reshape, so that non-reshape aware kernels do not try to assemble it 
(and cause data corruption).

Petr

