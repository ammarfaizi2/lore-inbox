Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265073AbTGAAK7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 20:10:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264731AbTGAAK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 20:10:58 -0400
Received: from adsl-66-120-156-55.dsl.lsan03.pacbell.net ([66.120.156.55]:59646
	"EHLO river.fishnet") by vger.kernel.org with ESMTP id S264889AbTGAAK5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 20:10:57 -0400
Date: Mon, 30 Jun 2003 17:25:16 -0700
Message-Id: <200307010025.h610PGmX007656@river.fishnet>
From: John Salmon <jsalmon@thesalmons.org>
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: negative tcp_tw_count and other TIME_WAIT weirdness?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have several fairly busy servers reporting a negative value
for tcp_tw_count.  For example:

bash-2.05a# cat /proc/net/sockstat
sockets: used 121
TCP: inuse 50 orphan 0 tw -65048 alloc 81 mem 26
UDP: inuse 15
RAW: inuse 1
FRAG: inuse 0 memory 0
bash-2.05a# 

When I look at netstat -n, I see many (hundreds) connections 
stuck in TIME_WAIT.  They've been there for at least a few hours,
and probably much longer (days).

Is this expected behavior?  A known bug?

FWIW, I'm using a RedHat kernel, 2.4.18-24.7.xsmp on a 2-processor Athlon
system.   If this looks like a bug I'll try to reproduce it with
an unmodified kernel.

Thanks,
John Salmon


