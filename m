Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268223AbUJDPl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268223AbUJDPl7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 11:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268240AbUJDPkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 11:40:05 -0400
Received: from host50.200-117-131.telecom.net.ar ([200.117.131.50]:1436 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S268223AbUJDPjJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 11:39:09 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3-mm2
Date: Mon, 4 Oct 2004 12:39:05 -0300
User-Agent: KMail/1.7.1
Cc: Mathieu Segaud <matt@minas-morgul.org>
References: <20041004020207.4f168876.akpm@osdl.org> <87oeji93co.fsf@barad-dur.crans.org>
In-Reply-To: <87oeji93co.fsf@barad-dur.crans.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410041239.05591.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Segaud wrote:
> Hum, and I can see that there is a fix to get reiser4 working with 4Kstacks
> but reiser4 option still doesn't appear if CONFIG_4KSTACKS is enabled.

On the contrary, it's a fix so it doesn't show on the menu when 4KSTACKS is 
selected:


diff -puN fs/Kconfig.reiser4~resier4-4kstacks-fix fs/Kconfig.reiser4
--- 25/fs/Kconfig.reiser4~resier4-4kstacks-fix 2004-08-21 14:21:30.716818728 
-0700
+++ 25-akpm/fs/Kconfig.reiser4 2004-08-21 14:21:42.306056896 -0700
@@ -1,6 +1,6 @@
 config REISER4_FS
  tristate "Reiser4 (EXPERIMENTAL very fast general purpose filesystem)"
- depends on EXPERIMENTAL
+ depends on EXPERIMENTAL && !4KSTACKS
  default y
  ---help---
    Reiser4 is more than twice as fast for both reads and writes as


Regards,
Norberto
