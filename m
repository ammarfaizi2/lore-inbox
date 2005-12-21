Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbVLUUQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbVLUUQP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 15:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932498AbVLUUQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 15:16:15 -0500
Received: from mato.luukku.com ([193.209.83.251]:33464 "EHLO mato.luukku.com")
	by vger.kernel.org with ESMTP id S932497AbVLUUQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 15:16:14 -0500
Date: Wed, 21 Dec 2005 22:15:13 +0200
From: Mika Kukkonen <mikukkon@iki.fi>
To: ralf@linux-mips.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-hams@vger.kernel.org
Subject: [PATCH] NETROM: Fix three if-statements in nr_state1_machine()
Message-ID: <20051221201513.GB24213@localhost.localdomain>
Reply-To: mikukkon@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found these while compiling with extra gcc warnings;
considering the indenting surely they are not intentional?

Signed-of-by: Mika Kukkonen <mikukkon@iki.fi>

---

 net/netrom/nr_in.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/netrom/nr_in.c b/net/netrom/nr_in.c
index 004e859..a7d88b5 100644
--- a/net/netrom/nr_in.c
+++ b/net/netrom/nr_in.c
@@ -99,7 +99,7 @@ static int nr_state1_machine(struct sock
 		break;
 
 	case NR_RESET:
-		if (sysctl_netrom_reset_circuit);
+		if (sysctl_netrom_reset_circuit)
 			nr_disconnect(sk, ECONNRESET);
 		break;
 
@@ -130,7 +130,7 @@ static int nr_state2_machine(struct sock
 		break;
 
 	case NR_RESET:
-		if (sysctl_netrom_reset_circuit);
+		if (sysctl_netrom_reset_circuit)
 			nr_disconnect(sk, ECONNRESET);
 		break;
 
@@ -265,7 +265,7 @@ static int nr_state3_machine(struct sock
 		break;
 
 	case NR_RESET:
-		if (sysctl_netrom_reset_circuit);
+		if (sysctl_netrom_reset_circuit)
 			nr_disconnect(sk, ECONNRESET);
 		break;
 

