Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267099AbTA0DRC>; Sun, 26 Jan 2003 22:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267112AbTA0DRC>; Sun, 26 Jan 2003 22:17:02 -0500
Received: from mta08bw.bigpond.com ([144.135.24.137]:54489 "EHLO
	mta08bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S267099AbTA0DRB> convert rfc822-to-8bit; Sun, 26 Jan 2003 22:17:01 -0500
Content-Type: text/plain; charset=US-ASCII
From: Srihari Vijayaraghavan <harisri@bigpond.com>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Solved 2.4.21-pre3aa1 and RAID-0 issue (was: Re: 2.4.21-pre3aa1 and RAID0 issue]
Date: Mon, 27 Jan 2003 14:41:11 +1100
User-Agent: KMail/1.4.3
References: <200212270856.13419.harisri@bigpond.com> <200301222007.48055.harisri@bigpond.com> <200301230102.25399.harisri@bigpond.com>
In-Reply-To: <200301230102.25399.harisri@bigpond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Cc: lkml <linux-kernel@vger.kernel.org>
Message-Id: <200301271441.11112.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

On Thursday 23 January 2003 01:02, Srihari Vijayaraghavan wrote:
> ...
> Ok. I did some more testing, and this is what happens:
> /sbin/raidstart /dev/md0 executes and exits fine under 2.4.21-pre3. Where
> as under 2.4.21-pre3aa1 it starts executing but _never_ exits (I waited for
> few minutes). I had to kill it using alt + sysrq + k.
> ...

The 9985_blk-atomic-aa5 patch is causing this regression. Backing this patch 
out of 2.4.21-pre3aa1 makes it to work nicely with Software RAID-0.

Thanks.
-- 
Hari
harisri@bigpond.com

