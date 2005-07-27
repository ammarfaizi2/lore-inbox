Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262411AbVG0Uc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262411AbVG0Uc0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 16:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVG0U3z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:29:55 -0400
Received: from ms-smtp-03-smtplb.rdc-nyc.rr.com ([24.29.109.7]:14263 "EHLO
	ms-smtp-03.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S261366AbVG0U2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:28:43 -0400
Message-ID: <42E7EE54.2080906@temple.edu>
Date: Wed, 27 Jul 2005 16:28:04 -0400
From: Nick Sillik <n.sillik@temple.edu>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Sillik <n.sillik@temple.edu>
CC: linux-kernel@vger.kernel.org, David Borowski <david575@golden.net>
Subject: Re: drivers/char/speakup/synthlist.h fix -Wundef errors
References: <42E7EBA9.5070404@temple.edu>
In-Reply-To: <42E7EBA9.5070404@temple.edu>
Content-Type: multipart/mixed;
 boundary="------------000807020008080109030707"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000807020008080109030707
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Nick Sillik wrote:
> This patch should fix a slew of -Wundef errors in the synthlist.h file 
> used by the speakup driver.
> 
> Nick Sillik
> n.sillik@temple.edu

Or maybe we could just eliminate the CFG_TEST from the file all 
together.... This patch follows that avenue.

--------------000807020008080109030707
Content-Type: text/plain;
 name="synthlist_wundef.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="synthlist_wundef.patch"

diff -urN a/drivers/char/speakup/synthlist.h b/drivers/char/speakup/synthlist.h
--- a/drivers/char/speakup/synthlist.h	2005-07-27 16:10:04.000000000 -0400
+++ b/drivers/char/speakup/synthlist.h	2005-07-27 16:24:02.000000000 -0400
@@ -7,46 +7,45 @@
 /* declare extern built in synths */
 #define SYNTH_DECL(who) extern struct spk_synth synth_##who;
 #define PASS2
-#define  CFG_TEST(name) (name)
 #endif
 
-#if CFG_TEST(CONFIG_SPEAKUP_ACNTPC)
+#ifdef CONFIG_SPEAKUP_ACNTPC
 SYNTH_DECL(acntpc)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_ACNTSA)
+#ifdef CONFIG_SPEAKUP_ACNTSA
 SYNTH_DECL(acntsa)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_APOLLO)
+#ifdef CONFIG_SPEAKUP_APOLLO
 SYNTH_DECL(apollo)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_AUDPTR)
+#ifdef CONFIG_SPEAKUP_AUDPTR
 SYNTH_DECL(audptr)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_BNS)
+#ifdef CONFIG_SPEAKUP_BNS
 SYNTH_DECL(bns)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_DECEXT)
+#ifdef CONFIG_SPEAKUP_DECEXT
 SYNTH_DECL(decext)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_DECTLK)
+#ifdef CONFIG_SPEAKUP_DECTLK
 SYNTH_DECL(dectlk)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_DTLK)
+#ifdef CONFIG_SPEAKUP_DTLK
 SYNTH_DECL(dtlk)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_KEYPC)
+#ifdef CONFIG_SPEAKUP_KEYPC
 SYNTH_DECL(keypc)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_LTLK)
+#ifdef CONFIG_SPEAKUP_LTLK
 SYNTH_DECL(ltlk)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_SFTSYN)
+#ifdef CONFIG_SPEAKUP_SFTSYN
 SYNTH_DECL(sftsyn)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_SPKOUT)
+#ifdef CONFIG_SPEAKUP_SPKOUT
 SYNTH_DECL(spkout)
 #endif
-#if CFG_TEST(CONFIG_SPEAKUP_TXPRT)
+#ifdef CONFIG_SPEAKUP_TXPRT
 SYNTH_DECL(txprt)
 #endif
 

--------------000807020008080109030707--
