Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbVHYUUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbVHYUUP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 16:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbVHYUUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 16:20:15 -0400
Received: from mail4.zigzag.pl ([217.11.136.106]:19863 "HELO mail4.zigzag.pl")
	by vger.kernel.org with SMTP id S932542AbVHYUUN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 16:20:13 -0400
Date: Thu, 25 Aug 2005 22:20:02 +0200
From: Lukasz Spaleniak <lspaleniak@wroc.zigzag.pl>
To: linux-kernel@vger.kernel.org
Cc: kadlec@netfilter.org, gandalf@netfilter.org, kaber@netfilter.org
Subject: Conntrack problem, machines freeze
Message-Id: <20050825222002.3538af7d.lspaleniak@wroc.zigzag.pl>
Organization: Internet Group SA
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BitDefender-Scanner: Clean, Agent: BitDefender Qmail 1.6.2 on
 mail4.zigzag.pl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have simple linux router with three fastethernet cards (intel , e100
driver). About two months ago it started hanging. It's completly
freezing machine (no ooops. First of all when it's booting few
messages like this appears on screen:

NF_IP_ASSERT: ip_conntrack_core.c:1128(ip_conntrack_alter_reply)

I suppose it's showing before firewall script load rules (simple nat).
After that somtimes it's working very long, sometimes it's freezing
after few seconds. One time I've logged this message before it freezes:

kernel: LIST_DELETE: ip_conntrack_core.c:302 `&ct->tuplehash
[IP_CT_DIR_REPLY]'(decb6084) not in &ip_conntrack_hash[hr].

Components that has been already replaced:
- computer hardware (twice to a new one)
- fast ethernet cards (tried with intel, realtek and 3com)
- fresh system (debian sarge)
- switches

Router and switches are connected to UPS (dedicated, also replaced).

This is a vanilla kernel 2.4.31, problem also exist with kernels:
2.4.30, 2.4.29. I tried also with grsecuriry(hoping it could help)
patch, but it wasn't.

If you have any idea what I can try to fix please let me know.

Thank you for your time.


Best regads,
Lukasz Spaleniak


-- 
spalek on zigzag dot pl
GCM dpu s: a--- C++ UL++++ P+ L+++ E--- W+ N+ K- w O- M V-
PGP t--- 5 X+ R- tv-- b DI- D- G e-- h! r y+
