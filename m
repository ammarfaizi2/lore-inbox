Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbUKGPop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbUKGPop (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 10:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261622AbUKGPoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 10:44:44 -0500
Received: from [195.56.65.174] ([195.56.65.174]:44037 "EHLO h.kenyer.hu")
	by vger.kernel.org with ESMTP id S261391AbUKGPon (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 10:44:43 -0500
Subject: weird NFSv3 getaddr storm when fileserver upgraded to 2.6 (tcpdump
	output)
From: dap <dap@kenyer.hu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1099842279.28539.158.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 07 Nov 2004 16:44:39 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I forgot to include a sample of tcpdump:

16:38:10.832970 IP (tos 0x0, ttl  64, id 0, offset 0, flags [DF], length: 120) 10.1.1.2.2357056995 > 10.1.1.251.2049: 92 getattr fh Unknown/0100000000FD000102000000267681BD418C2B8107B03430418C2B8107B03430
16:38:10.833004 IP (tos 0x0, ttl  64, id 13797, offset 0, flags [DF], length: 140) 10.1.1.251.2049 > 10.1.1.2.2357056995: reply ok 112 getattr DIR 40755 ids 0/0 sz 0x1000
16:38:10.833159 IP (tos 0x0, ttl  64, id 0, offset 0, flags [DF], length: 120) 10.1.1.2.2373834211 > 10.1.1.251.2049: 92 getattr fh Unknown/0100000000FD000102000000267681BD418C2B8107B03430418C2B8107B03430
16:38:10.833223 IP (tos 0x0, ttl  64, id 13804, offset 0, flags [DF], length: 140) 10.1.1.251.2049 > 10.1.1.2.2373834211: reply ok 112 getattr DIR 40755 ids 0/0 sz 0x1000
16:38:10.833372 IP (tos 0x0, ttl  64, id 0, offset 0, flags [DF], length: 120) 10.1.1.2.2390611427 > 10.1.1.251.2049: 92 getattr fh Unknown/0100000000FD000102000000267681BD418C2B8107B03430418C2B8107B03430
16:38:10.833399 IP (tos 0x0, ttl  64, id 13812, offset 0, flags [DF], length: 140) 10.1.1.251.2049 > 10.1.1.2.2390611427: reply ok 112 getattr DIR 40755 ids 0/0 sz 0x1000
16:38:10.833551 IP (tos 0x0, ttl  64, id 0, offset 0, flags [DF], length: 120) 10.1.1.2.2407388643 > 10.1.1.251.2049: 92 getattr fh Unknown/0100000000FD000102000000267681BD418C2B8107B03430418C2B8107B03430
16:38:10.833602 IP (tos 0x0, ttl  64, id 13819, offset 0, flags [DF], length: 140) 10.1.1.251.2049 > 10.1.1.2.2407388643: reply ok 112 getattr DIR 40755 ids 0/0 sz 0x1000
16:38:10.833751 IP (tos 0x0, ttl  64, id 0, offset 0, flags [DF], length: 120) 10.1.1.2.2424165859 > 10.1.1.251.2049: 92 getattr fh Unknown/0100000000FD000102000000267681BD418C2B8107B03430418C2B8107B03430
16:38:10.833783 IP (tos 0x0, ttl  64, id 13825, offset 0, flags [DF], length: 140) 10.1.1.251.2049 > 10.1.1.2.2424165859: reply ok 112 getattr DIR 40755 ids 0/0 sz 0x1000


-- 
dap

