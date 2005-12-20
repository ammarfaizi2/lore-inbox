Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932117AbVLTVVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbVLTVVg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 16:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbVLTVVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 16:21:36 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58547 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932117AbVLTVVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 16:21:35 -0500
Date: Tue, 20 Dec 2005 16:21:27 -0500
From: Dave Jones <davej@redhat.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: remove incorrect dependancy on CONFIG_APM
Message-ID: <20051220212127.GA6833@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From the PM_LEGACY Kconfig description..

"Support for pm_register() and friends."

Note, no mention of 'make apm stop working'.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.14/arch/i386/Kconfig~	2005-12-20 16:19:17.000000000 -0500
+++ linux-2.6.14/arch/i386/Kconfig	2005-12-20 16:19:21.000000000 -0500
@@ -710,7 +710,7 @@ depends on PM && !X86_VISWS
 
 config APM
 	tristate "APM (Advanced Power Management) BIOS support"
-	depends on PM && PM_LEGACY
+	depends on PM
 	---help---
 	  APM is a BIOS specification for saving power using several different
 	  techniques. This is mostly useful for battery powered laptops with
