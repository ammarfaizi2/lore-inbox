Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbWAFHia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWAFHia (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 02:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752433AbWAFHia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 02:38:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:29837 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750912AbWAFHi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 02:38:29 -0500
Date: Fri, 6 Jan 2006 02:38:19 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Allow iseries to disable input layer without CONFIG_EMBEDDED
Message-ID: <20060106073819.GA731@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

iSeries has no keyboard, so it's valid to build a kernel with no input layer.
It seems a bit absurd to call one of these 'embedded'.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.15/drivers/input/Kconfig~	2006-01-06 02:27:56.000000000 -0500
+++ linux-2.6.15/drivers/input/Kconfig	2006-01-06 02:28:08.000000000 -0500
@@ -5,7 +5,7 @@
 menu "Input device support"
 
 config INPUT
-	tristate "Generic input layer (needed for keyboard, mouse, ...)" if EMBEDDED
+	tristate "Generic input layer (needed for keyboard, mouse, ...)"
 	default y
 	---help---
 	  Say Y here if you have any input device (mouse, keyboard, tablet,
