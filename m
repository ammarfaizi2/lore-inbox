Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbVLAWR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbVLAWR3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 17:17:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932523AbVLAWR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 17:17:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33414 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932525AbVLAWR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 17:17:29 -0500
Date: Thu, 1 Dec 2005 17:17:13 -0500
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org
Subject: missing printk newline in apic boot option parser.
Message-ID: <20051201221713.GA19581@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Missing newline in printk.

Signed-off-by: Dave Jones <davej@redhat.com>

--- vanilla/arch/i386/kernel/apic.c~	2005-12-01 17:15:34.000000000 -0500
+++ vanilla/arch/i386/kernel/apic.c	2005-12-01 17:15:54.000000000 -0500
@@ -715,7 +715,7 @@ static int __init apic_set_verbosity(cha
 		apic_verbosity = APIC_VERBOSE;
 	else
 		printk(KERN_WARNING "APIC Verbosity level %s not recognised"
-				" use apic=verbose or apic=debug", str);
+				" use apic=verbose or apic=debug\n", str);
 
 	return 0;
 }
