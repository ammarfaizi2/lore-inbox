Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932284AbWDLRds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWDLRds (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 13:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbWDLRds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 13:33:48 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:15813 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932281AbWDLRdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 13:33:38 -0400
Message-ID: <7986404.1144863211340.SLOX.WebMail.wwwrun@exchange.deltacomputer.de>
Date: Wed, 12 Apr 2006 19:33:31 +0200 (CEST)
From: Oliver Weihe <o.weihe@deltacomputer.de>
To: linux-kernel@vger.kernel.org, ak@suse.de
Subject: Opteron 128GB NODMAPSIZE too small?
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3 (normal)
X-Mailer: SuSE Linux Openexchange Server 4 - WebMail (Build 2.4160)
X-Operating-System: Linux 2.4.21-295-smp i386 (JVM 1.3.1_13)
Organization: Delta Computer Products GmbH
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:62e2eaa30f0557f14c09a5fa777a0a78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While running SuSE Linux 10.0 (x86_64) with a vanilla 2.6.16.1 on an
8way (8 sockets) Opteron equipped with 128GB (16GB per socket) of memory
I found this in dmesg.

Any guesses to which value I should set NODEMAPSIZE?
Currently it is 0xfff (from 'include/asm-x86_64/mmzone.h')

Scanning NUMA topology in Northbridge 24
Number of nodes 8
Node 0 MemBase 0000000000000000 Limit 0000000422000000
Node 1 MemBase 0000000422000000 Limit 0000000822000000
Node 2 MemBase 0000000822000000 Limit 0000000c22000000
Node 3 MemBase 0000000c22000000 Limit 0000001022000000
Node 4 MemBase 0000001022000000 Limit 0000001422000000
Node 5 MemBase 0000001422000000 Limit 0000001822000000
Node 6 MemBase 0000001822000000 Limit 0000001c22000000
Node 7 MemBase 0000001c22000000 Limit 0000002022000000
NUMA: Using 25 for the hash shift.
Your memory is not aligned you need to rebuild your kernel with a bigger
NODEMAPSIZE shift=25
No NUMA node hash function found. Contact maintainer
No NUMA configuration found
Faking a node at 0000000000000000-0000002022000000
Bootmem setup node 0 0000000000000000-0000002022000000


Regards,
  Oliver Weihe

