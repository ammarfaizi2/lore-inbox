Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266700AbUAWVc5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 16:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266702AbUAWVc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 16:32:57 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:28588 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S266700AbUAWVc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 16:32:56 -0500
Date: Fri, 23 Jan 2004 21:31:35 +0000
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: DMI updates from 2.4
Message-ID: <20040123213135.GA26776@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	torvalds@osdl.org
References: <E1Ajuub-0000x4-00@hardwired> <20040122233734.3ffe096b.akpm@osdl.org> <20040123074856.GH9327@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040123074856.GH9327@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 23, 2004 at 07:48:57AM +0000, Dave Jones wrote:
 > On Thu, Jan 22, 2004 at 11:37:34PM -0800, Andrew Morton wrote:
 >  > davej@redhat.com wrote:
 >  > >
 >  > > +static __init int apm_is_horked_d850md(struct dmi_blacklist *d)
 >  > 
 >  > this new function is unreferenced.
 > 
 > ok, I'll chase that one down later.

fix0red..

Made to match that in 2.4

		Dave

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1153  -> 1.1154 
#	arch/i386/kernel/dmi_scan.c	1.48    -> 1.49   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/01/23	davej@redhat.com	1.1154
# wire up dmi string
# --------------------------------------------
#
diff -Nru a/arch/i386/kernel/dmi_scan.c b/arch/i386/kernel/dmi_scan.c
--- a/arch/i386/kernel/dmi_scan.c	Fri Jan 23 21:30:50 2004
+++ b/arch/i386/kernel/dmi_scan.c	Fri Jan 23 21:30:50 2004
@@ -660,7 +660,7 @@
 			MATCH(DMI_BIOS_VERSION, "Version1.01"),
 			NO_MATCH, NO_MATCH,
 			} },
-	{ apm_is_horked, "Intel D850MD", { /* APM crashes */
+	{ apm_is_horked_d850md, "Intel D850MD", { /* APM crashes */
 			MATCH(DMI_BIOS_VENDOR, "Intel Corp."),
 			MATCH(DMI_BIOS_VERSION, "MV85010A.86A.0016.P07.0201251536"),
 			NO_MATCH, NO_MATCH,
