Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTLCVhi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 16:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbTLCVhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 16:37:38 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:17931 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261605AbTLCVha
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 16:37:30 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: aacraid and large memory problem (2.6.0-test11)
Date: 3 Dec 2003 21:26:21 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bqlkdt$jqo$1@gatekeeper.tmr.com>
References: <20031203205730.88B7EF7C86@voldemort.scrye.com>
X-Trace: gatekeeper.tmr.com 1070486781 20312 192.168.12.62 (3 Dec 2003 21:26:21 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031203205730.88B7EF7C86@voldemort.scrye.com>,
Kevin Fenzi  <kevin@tummy.com> wrote:

| Bill> | > Perhaps this patch in 2.6.0-test9 is the culprit?  | >
| Bill> http://www.linuxhq.com/kernel/v2.6/0-test9/drivers/scsi/aacraid/comminit.c
| Bill> | | This patch is what made aacraid work with over 4 gig of
| Bill> memory for me. | I have an 8 proc system with 16gig of memory
| Bill> and without this patch I | get data corruption in high memory.
| Bill> | | I don't boot on the aacraid though.
| 
| Bill> It would be interesting to know what memory model is being used
| Bill> in each case. Both CONFIG_HIGHMEM* and maybe user/kernel split
| Bill> might play.
| 
| I am using the 2.6.0 rpms from:
| 
| http://people.redhat.com/arjanv/2.5/
| 
| Specifically its:
| 
| http://people.redhat.com/arjanv/2.5/RPMS.kernel/kernel-smp-2.6.0-0.test11.1.99.i686.rpm
| 
| The  kernel-2.6.0-test11-i686-smp.config
| says: 
| 
| # CONFIG_NOHIGHMEM is not set
| # CONFIG_HIGHMEM4G is not set
| CONFIG_HIGHMEM64G=y
| CONFIG_HIGHMEM=y
| CONFIG_BLK_DEV_UMEM=m
| CONFIG_DEBUG_HIGHMEM=y
| 
| Bill> Based on one boot with one machine, 4G RAM, it didn't hang.
| Bill> Unfortunately a production machine, I was playing following some
| Bill> "unscheduled maintenence."  
| 
| Did you have HIGHMEM set?

root> grep HIGHMEM .config
CONFIG_NOHIGHMEM=y
# CONFIG_HIGHMEM4G is not set
# CONFIG_HIGHMEM64G is not set

| kevin

I don't know that this sheds any light, one is a fairly small sample set.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
