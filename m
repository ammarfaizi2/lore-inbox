Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265939AbUBBTr2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 14:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265958AbUBBTqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 14:46:20 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:18004 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S265939AbUBBTox
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 14:44:53 -0500
X-BrightmailFiltered: true
Date: Mon, 2 Feb 2004 20:44:52 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 11/42]
Message-ID: <20040202194452.GK6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


include/asm/smpboot.h:126: warning: deprecated use of label at end of compound statement

Move the return statement under 'default' label to suppress the warning.

diff -Nru -X dontdiff linux-2.4-vanilla/include/asm-i386/smpboot.h linux-2.4/include/asm-i386/smpboot.h
--- linux-2.4-vanilla/include/asm-i386/smpboot.h	Tue Nov 11 17:51:14 2003
+++ linux-2.4/include/asm-i386/smpboot.h	Sat Jan 31 17:10:50 2004
@@ -123,8 +123,8 @@
 			cpu = (cpu+1)%smp_num_cpus;
 			return cpu_to_physical_apicid(cpu);
 		default:
+			return cpu_online_map;
 	}
-	return cpu_online_map;
 }
 #else
 #define target_cpus() (cpu_online_map)


-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Ci sono due cose che l'uomo non puo` nascondere:
essere ubriaco ed essere innamorato.
