Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267059AbUBEXWB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 18:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267058AbUBEXTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 18:19:51 -0500
Received: from galileo.bork.org ([66.11.174.156]:15044 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S266895AbUBEXSe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 18:18:34 -0500
Date: Thu, 5 Feb 2004 18:18:32 -0500
From: Martin Hicks <mort@wildopensource.com>
To: Martin Hicks <mort@wildopensource.com>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove __exit from mptscsih_exit()
Message-ID: <20040205231832.GD28976@localhost>
References: <20040205231719.GC28976@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20040205231719.GC28976@localhost>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline



On Thu, Feb 05, 2004 at 06:17:19PM -0500, Martin Hicks wrote:
> 
> Hi James and Andrew
> 
> I needed to apply this patch to get my kernel to link on ia64.  The
> patch is against 2.6.2-mm1

and the patch this time...

-- 
Martin Hicks                Wild Open Source Inc.
mort@wildopensource.com     613-266-2296

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mptscsi-exit-section.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1552  -> 1.1553 
#	drivers/message/fusion/mptscsih.c	1.32    -> 1.33   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 04/02/05	mort@green.i.bork.org	1.1553
# Get rid of __exit from mptscsih_exit() to get the
# kernel to link.
# --------------------------------------------
#
diff -Nru a/drivers/message/fusion/mptscsih.c b/drivers/message/fusion/mptscsih.c
--- a/drivers/message/fusion/mptscsih.c	Thu Feb  5 18:13:39 2004
+++ b/drivers/message/fusion/mptscsih.c	Thu Feb  5 18:13:39 2004
@@ -198,7 +198,7 @@
 
 /* module entry point */
 static int  __init    mptscsih_init  (void);
-static void __exit    mptscsih_exit  (void);
+static void    mptscsih_exit  (void);
 
 static int  __devinit mptscsih_probe (struct pci_dev *, const struct pci_device_id *);
 static void __devexit mptscsih_remove(struct pci_dev *);
@@ -1985,7 +1985,7 @@
  *
  */
 static void
-__exit mptscsih_exit(void)
+mptscsih_exit(void)
 {
 	MPT_ADAPTER	*ioc;
 

--ikeVEW9yuYc//A+q--
