Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263145AbTJUPxu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 11:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263153AbTJUPxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 11:53:49 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:55826 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263145AbTJUPxq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 11:53:46 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: 2.6.0-test8-mm1
Date: 21 Oct 2003 15:43:44 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bn3k7g$h24$1@gatekeeper.tmr.com>
References: <20031020020558.16d2a776.akpm@osdl.org>
X-Trace: gatekeeper.tmr.com 1066751024 17476 192.168.12.62 (21 Oct 2003 15:43:44 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031020020558.16d2a776.akpm@osdl.org>,
Andrew Morton  <akpm@osdl.org> wrote:
| 
| ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test8/2.6.0-test8-mm1
| 
| 
| . Included a much updated fbdev patch.  Anyone who is using framebuffers,
|   please test this.
| 
| . Quite a large number of stability fixes.
| 
| 
| 
| Changes since 2.6.0-test7-mm1:

| +devfs-initrd-fix.patch
| 
|  Fix initrd when devfs is in use

I casually followed the thread on this, is this a band-aid or a magic
spell of healing? Do you consider this a "real fix" for the various
problems people reported?
 
| +export-system_running.patch
| +might_sleep-early-bogons.patch
| 
|  Stomp all the early might_sleep() warnings.

Sort of the same question, were the warnings really bogus, or were
people just not doing the things which might cause a real error?

| +slab-leak-detector.patch
| +slab-leak-detector-tweaks.patch
| 
|  A slab debugging tool for finding memory leaks: do
| 
| 	echo "slab-name 0 0 0" > /proc/slabinfo
| 
|  and the kernel will inspect each live object in that cache and will print
|  out the code address from which the allocation was performed.

Neat!

| +parport_pc-resource-release-fix.patch
| 
|  Fix an oopsable resource leak in parport_pc.

I'll try my old parport ZIP drive (ppa) again this weekend.

| +ext3-latency-fix.patch
| 
|  Improved scheduling latency in ext3.

Did someone have measurements on this?


Compiling as I type.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
