Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267650AbUIWRQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267650AbUIWRQH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 13:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268197AbUIWROa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 13:14:30 -0400
Received: from host50.200-117-131.telecom.net.ar ([200.117.131.50]:64235 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S267650AbUIWROM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 13:14:12 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] voluntary-preempt-2.6.9-rc2-mm1-S4
Date: Thu, 23 Sep 2004 14:13:59 -0300
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <20040907115722.GA10373@elte.hu> <20040923130949.GB12984@elte.hu> <200409231346.21398.norberto+linux-kernel@bensa.ath.cx>
In-Reply-To: <200409231346.21398.norberto+linux-kernel@bensa.ath.cx>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409231414.00356.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Norberto Bensa wrote:
> Is it me or does this patch broke quiet command-line parameter?

Ingo, is this on purpose:

--- linux/kernel/printk.c.orig 
+++ linux/kernel/printk.c 
@@ -401,7 +401,7 @@ static void __call_console_drivers(unsig
 static void _call_console_drivers(unsigned long start,
     unsigned long end, int msg_log_level)
 {
- if (msg_log_level < console_loglevel &&
+ if (/*msg_log_level < console_loglevel && */
    console_drivers && start != end) {
   if ((start & LOG_BUF_MASK) > (end & LOG_BUF_MASK)) {
    /* wrapped write */


If so, why is it needed?

Thanks,
Norberto
