Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266813AbUG1HNs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266813AbUG1HNs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 03:13:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266790AbUG1HM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 03:12:56 -0400
Received: from ozlabs.org ([203.10.76.45]:6282 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266796AbUG1HLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 03:11:47 -0400
Date: Wed, 28 Jul 2004 16:55:26 +1000
From: David Gibson <hermes@gibson.dropbear.id.au>
To: Jeff Garzik <jgarzik@pobox.com>, Francois Romieu <romieu@fr.zoreil.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>, jt@hpl.hp.com,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>,
       Orinoco Development List <orinoco-devel@lists.sourceforge.net>
Subject: [5/15] orinoco merge preliminaries - use ARRAY_SIZE()
Message-ID: <20040728065526.GH16908@zax>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Francois Romieu <romieu@fr.zoreil.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>,
	jt@hpl.hp.com, Dan Williams <dcbw@redhat.com>,
	Pavel Roskin <proski@gnu.org>,
	Orinoco Development List <orinoco-devel@lists.sourceforge.net>
References: <20040712213349.A2540@electric-eye.fr.zoreil.com> <40F57D78.9080609@pobox.com> <20040715010137.GB3697@zax> <41068E4B.2040507@pobox.com> <20040728065128.GC16908@zax> <20040728065308.GD16908@zax> <20040728065345.GE16908@zax> <20040728065418.GF16908@zax> <20040728065450.GG16908@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728065450.GG16908@zax>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the built in ARRAY_SIZE macro, instead of hard coding it
ourselves.

Signed-off-by: David Gibson <hermes@gibson.dropbear.id.au>

Index: working-2.6/drivers/net/wireless/orinoco.c
===================================================================
--- working-2.6.orig/drivers/net/wireless/orinoco.c	2004-07-28 14:33:14.111384944 +1000
+++ working-2.6/drivers/net/wireless/orinoco.c	2004-07-28 14:33:17.540863584 +1000
@@ -507,7 +507,7 @@
 	2412, 2417, 2422, 2427, 2432, 2437, 2442,
 	2447, 2452, 2457, 2462, 2467, 2472, 2484
 };
-#define NUM_CHANNELS ( sizeof(channel_frequency) / sizeof(channel_frequency[0]) )
+#define NUM_CHANNELS ARRAY_SIZE(channel_frequency)
 
 /* This tables gives the actual meanings of the bitrate IDs returned by the firmware. */
 struct {
@@ -525,7 +525,7 @@
 	{55,  1,  7,  7},
 	{110, 0,  5,  8},
 };
-#define BITRATE_TABLE_SIZE (sizeof(bitrate_table) / sizeof(bitrate_table[0]))
+#define BITRATE_TABLE_SIZE ARRAY_SIZE(bitrate_table)
 
 /********************************************************************/
 /* Data types                                                       */

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
