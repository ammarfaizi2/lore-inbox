Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbTIKUXv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 16:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbTIKUXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 16:23:51 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:55302 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261497AbTIKUXm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 16:23:42 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Date: 11 Sep 2003 20:14:47 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bjql3n$tde$1@gatekeeper.tmr.com>
References: <1063289641.2967.3.camel@dhcp23.swansea.linux.org.uk> <20030911162421.419f4432.ak@suse.de>
X-Trace: gatekeeper.tmr.com 1063311287 30126 192.168.12.62 (11 Sep 2003 20:14:47 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030911162421.419f4432.ak@suse.de>,
Andi Kleen  <ak@suse.de> wrote:
| On Thu, 11 Sep 2003 15:14:02 +0100
| Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
| 
| > 
| > There is *one* change needed. We shouldnt call is_prefetch unless the
| > current CPU is an Athlon. That way its a performance improvement for
| > PIV, and Athlon in general, fixes the bug and causes no fancy athlon
| > fixup code for non AMD processors.
| 
| I considered that when writing the patch, but: is_prefetch is a single byte 
| memory access for something already in cache. Checking for an Athlon
| CPU needs two memory accesses in boot_cpu_data at least (checking vendor
| and model) 

You are still missing the point, what's needed is not a better way to do
useless work, it's a way to avoid doing it at all. This code should only
be built for CPU's which need it, no accesses needed except in .config.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
