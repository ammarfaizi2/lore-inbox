Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265080AbTLCQ1e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 11:27:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265081AbTLCQ1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 11:27:34 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:28170 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265080AbTLCQ11
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 11:27:27 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: aacraid and large memory problem (2.6.0-test11)
Date: 3 Dec 2003 16:16:18 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bql28i$i5e$1@gatekeeper.tmr.com>
References: <20031202193520.74481F7CC8@voldemort.scrye.com> <1070396482.16903.11.camel@markh1.pdx.osdl.net>
X-Trace: gatekeeper.tmr.com 1070468178 18606 192.168.12.62 (3 Dec 2003 16:16:18 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1070396482.16903.11.camel@markh1.pdx.osdl.net>,
Mark Haverkamp  <markh@osdl.org> wrote:
| On Tue, 2003-12-02 at 11:35, Kevin Fenzi wrote:
| > -----BEGIN PGP SIGNED MESSAGE-----
| > Hash: SHA1
| > 
| > 
| > Greetings, 
| > 
| > Booting 2.6.0-test11 on a machine with 8GB memory and using the
| > aacraid driver results in a hang on boot. Passing mem=2048M causes it
| > to boot normally. 4GB also hangs. 2.6.0-test8 booted normally on this
| > same hardware. 
| > 
| > 8GB memory, dual xeon 3.06mhz with hyperthreading, RedHat 9 on it
| > currently. 
| > 
| > Happy to provide details on setup/software, etc. 
| > 
| > Perhaps this patch in 2.6.0-test9 is the culprit?
| > http://www.linuxhq.com/kernel/v2.6/0-test9/drivers/scsi/aacraid/comminit.c
| 
| This patch is what made aacraid work with over 4 gig of memory for me. 
| I have an 8 proc system with 16gig of memory and without this patch I
| get data corruption in high memory.
| 
| I don't boot on the aacraid though.

It would be interesting to know what memory model is being used in each
case. Both CONFIG_HIGHMEM* and maybe user/kernel split might play.

Based on one boot with one machine, 4G RAM, it didn't hang.
Unfortunately a production machine, I was playing following some
"unscheduled maintenence."
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
