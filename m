Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261217AbVBZPEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261217AbVBZPEF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 10:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVBZPEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 10:04:05 -0500
Received: from hera.cwi.nl ([192.16.191.8]:59627 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261217AbVBZPEC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 10:04:02 -0500
Date: Sat, 26 Feb 2005 16:03:59 +0100
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] more apic.c
Message-ID: <20050226150357.GA19651@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

setup_APIC_timer is only called in __init context and uses __initdata

Andries

diff -uprN -X /linux/dontdiff a/arch/i386/kernel/apic.c b/arch/i386/kernel/apic.c
--- a/arch/i386/kernel/apic.c	2005-02-26 12:13:28.000000000 +0100
+++ b/arch/i386/kernel/apic.c	2005-02-26 16:13:21.000000000 +0100
@@ -930,7 +930,7 @@ void __setup_APIC_LVTT(unsigned int cloc
 	apic_write_around(APIC_TMICT, clocks/APIC_DIVISOR);
 }
 
-static void setup_APIC_timer(unsigned int clocks)
+static void __init setup_APIC_timer(unsigned int clocks)
 {
 	unsigned long flags;
 
