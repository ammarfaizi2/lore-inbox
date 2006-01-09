Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750715AbWAITPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750715AbWAITPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 14:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750716AbWAITPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 14:15:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:48863 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750715AbWAITPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 14:15:17 -0500
Date: Mon, 9 Jan 2006 11:15:07 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] random: get rid of sparse warning
Message-ID: <20060109111507.7aedd31e@dxpl.pdx.osdl.net>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of bogus extern attribute that causes sparse warning.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>


--- linux-2.6.orig/drivers/char/random.c
+++ linux-2.6/drivers/char/random.c
@@ -632,7 +632,7 @@ out:
 	preempt_enable();
 }
 
-extern void add_input_randomness(unsigned int type, unsigned int code,
+void add_input_randomness(unsigned int type, unsigned int code,
 				 unsigned int value)
 {
 	static unsigned char last_value;
