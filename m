Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbVG0Ioy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVG0Ioy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 04:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbVG0Ioy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 04:44:54 -0400
Received: from highlandsun.propagation.net ([66.221.212.168]:56327 "EHLO
	highlandsun.propagation.net") by vger.kernel.org with ESMTP
	id S261983AbVG0Iox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 04:44:53 -0400
Message-ID: <42E7497B.5040202@highlandsun.com>
Date: Wed, 27 Jul 2005 01:44:43 -0700
From: Howard Chu <hyc@highlandsun.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b2) Gecko/20050621
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.12.3 network slowdown?
References: <1122452018.772579.63900@g49g2000cwa.googlegroups.com> <20050727082020.C73AC5F7CA@attila.bofh.it>
In-Reply-To: <20050727082020.C73AC5F7CA@attila.bofh.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just recently compiled the 2.6.12.3 kernel for my x86_64 machine
(Asus A8V motherboard); was previously running a SuSE-compiled 2.6.8
kernel (SuSE 9.2 distro). I'm now seeing extremely slow throughput on
the onboard Yukon (Marvell) ethernet interface, but only in certain
conditions. Going back to the 2.6.8 kernel shows no slowdown.

I have a few machines connected to a Linksys 5 port 10/100 hub. There
is also a Linksys WRT54G wireless router on this hub. When doing a raw 
ftp transfer of a large (600MB) file (using a Windows XP client to do a
GET) with both machines plugged into the hub, I see transfer rates only
as high as 1MB/sec initially, which quickly degrades to ~200KB/sec over 
a span of 20-30 seconds. Going the opposite direction, a PUT runs at a 
steady 7.5MB/sec.

If I unplug the Windows client and just connect via the wireless 
network, I see GETs run a steady 2.8MB/sec and PUTs run a steady 
3.2MB/sec, which is about the same as I saw with the 2.6.8 kernel, so 
that all appears normal. (But it's still odd, that adding one hop like 
this avoids the throughput degradation.)

I don't see any collisions or any other errors on the ifconfig 
statistics, just a very slow transmit rate. Does anyone recognize this 
symptom? Any suggestions on tunables to tweak, etc.? (Please cc: me 
directly when replying, thanks.)

-- 
   -- Howard Chu
   Chief Architect, Symas Corp.  http://www.symas.com
   Director, Highland Sun        http://highlandsun.com/hyc
   OpenLDAP Core Team            http://www.openldap.org/project/
