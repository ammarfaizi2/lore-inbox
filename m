Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265897AbUBBT7O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 14:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265869AbUBBT5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 14:57:39 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:12147 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S265843AbUBBT5F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:57:05 -0500
X-BrightmailFiltered: true
Date: Mon, 2 Feb 2004 20:57:04 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 23/42]
Message-ID: <20040202195704.GW6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ircomm_param.c:202: warning: concatenation of string literals with __FUNCTION__ is deprecated

Fix IRDA_DEBUG.

diff -Nru -X dontdiff linux-2.4-vanilla/net/irda/ircomm/ircomm_param.c linux-2.4/net/irda/ircomm/ircomm_param.c
--- linux-2.4-vanilla/net/irda/ircomm/ircomm_param.c	Tue Nov 11 17:51:41 2003
+++ linux-2.4/net/irda/ircomm/ircomm_param.c	Sat Jan 31 18:09:39 2004
@@ -198,7 +198,7 @@
 		IRDA_DEBUG(2, "%s(), No common service type to use!\n", __FUNCTION__);
 		return -1;
 	}
-	IRDA_DEBUG(0, __FUNCTION__ "%s(), services in common=%02x\n", __FUNCTION__,
+	IRDA_DEBUG(0, "%s(), services in common=%02x\n", __FUNCTION__,
 		   service_type);
 
 	/*

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Windows /win'dohz/ n. : thirty-two  bit extension and graphical shell to
a sixteen  bit patch to an  eight bit operating system  originally coded
for a  four bit microprocessor  which was  written by a  two-bit company
that can't stand a bit of competition.
