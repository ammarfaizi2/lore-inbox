Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbTICPze (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 11:55:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263737AbTICPzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 11:55:08 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:4366 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263795AbTICPyL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 11:54:11 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [2.6 patch] more BROKEN{,ON_SMP}
Date: 3 Sep 2003 15:45:23 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bj52aj$794$1@gatekeeper.tmr.com>
References: <20030902153819.GK23729@fs.tum.de>
X-Trace: gatekeeper.tmr.com 1062603923 7460 192.168.12.62 (3 Sep 2003 15:45:23 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030902153819.GK23729@fs.tum.de>,
Adrian Bunk  <bunk@fs.tum.de> wrote:
| Hi Linus,
| 
| the patch below against 2.6.0-test4 does the following:
| 
| - let more drivers that don't compile depend on BROKEN
| - MTD_BLKMTD is fixed, remove the dependency on BROKEN
| - let all drivers that don't compile on SMP (due to cli/sti usage)
|   depend on a BROKEN_ON_SMP that is only defined if !SMP || BROKEN
| - #include interrupt.h for dummy cli/sti/... in two files to fix the
|   UP compilation of these files
| 
| I marked only drivers that are broken for a long time and where I don't 
| know about existing fixes with BROKEN or BROKEN_ON_SMP.

Thanks! This makes testing far easier.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
