Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271270AbTHRGQm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 02:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271272AbTHRGQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 02:16:42 -0400
Received: from mailhost.NMT.EDU ([129.138.4.52]:61652 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id S271270AbTHRGQl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 02:16:41 -0400
Date: Mon, 18 Aug 2003 00:15:11 -0600
From: Val Henson <val@nmt.edu>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [bk patches] add ethtool_ops to net drivers
Message-ID: <20030818061511.GA1255@speare5-1-14>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I needed the following patch to compile netsyms.c - just a missing
include.

Thanks,

-VAL

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1214  -> 1.1215 
#	       net/netsyms.c	1.93    -> 1.94   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/08/17	val@host4.sbcglobal.net	1.1215
# Add missing include for ethtool ops
# --------------------------------------------
#
diff -Nru a/net/netsyms.c b/net/netsyms.c
--- a/net/netsyms.c	Sun Aug 17 20:26:07 2003
+++ b/net/netsyms.c	Sun Aug 17 20:26:07 2003
@@ -626,6 +626,7 @@
 EXPORT_SYMBOL(linkwatch_fire_event);
 
 /* ethtool.c */
+#include <linux/ethtool.h>
 EXPORT_SYMBOL(ethtool_op_get_link);
 EXPORT_SYMBOL(ethtool_op_get_tx_csum);
 EXPORT_SYMBOL(ethtool_op_get_sg);
