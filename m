Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262147AbVDFJJU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVDFJJU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 05:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262150AbVDFJJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 05:09:20 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:27364 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262147AbVDFJJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 05:09:15 -0400
Message-ID: <4253A731.3090006@ens-lyon.org>
Date: Wed, 06 Apr 2005 11:09:05 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050116)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
References: <20050405000524.592fc125.akpm@osdl.org> <425240C5.1050706@ens-lyon.org> <20050405083001.GA28068@elte.hu> <42524EE2.5010703@ens-lyon.org> <20050405183413.GA7122@elte.hu>
In-Reply-To: <20050405183413.GA7122@elte.hu>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: *  0.1 RCVD_IN_SORBS_DUL RBL: SORBS: sent directly from dynamic IP address
	*      [81.50.29.87 listed in dnsbl.sorbs.net]
	*  1.6 RCVD_IN_NJABL_DUL RBL: NJABL: dialup sender did non-local SMTP
	*      [81.50.29.87 listed in combined.njabl.org]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar a écrit :
> weird - none of the WARN_ON(1)'s show up. In particular, the 
> sched_clock() ones should have triggered at least once! I've attached a 
> new version of the patch below (please unapply the previous patch), 
> could you try it and send me the log?  (It will unconditionally print 
> something in tsc_init(), which is always called during the boot 
> process.)

Hi Ingo,

The result is exactly the same, except the following lines at the 
begining of dmesg. Note that only these lines have a valid timestamp.
All remaining lines show 0.000.

[4294667.296000] Linux version 2.6.12-rc2-mm1=LoulousMobile 
(bgoglin@puligny) (version gcc 3.3.5 (Debian 1:3.3.5-8)) #9 PREEMPT Tue 
Apr 5 09:28:57 CEST 2005
[4294667.296000] Badness in sched_clock at 
arch/i386/kernel/timers/timer_tsc.c:143
[4294667.296000]  [<c010f464>] sched_clock+0x84/0x110
[4294667.296000]  [<c01d7b5b>] vscnprintf+0x2b/0x40
[4294667.296000]  [<c011e252>] vprintk+0xa2/0x260
[4294667.296000]  [<c011e1a7>] printk+0x17/0x20
[4294667.296000]  [<c046f6f4>] start_kernel+0x14/0x180
[4294667.296000] art_kernel+0x14/0x180

Brice
