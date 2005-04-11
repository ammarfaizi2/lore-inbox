Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVDKQu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVDKQu4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbVDKQri
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:47:38 -0400
Received: from bernache.ens-lyon.fr ([140.77.167.10]:29929 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261861AbVDKQqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:46:39 -0400
Date: Mon, 11 Apr 2005 18:46:07 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
Subject: [2.6 ppc patch] fix compilation error in arch/ppc/syslib/open_pic_defs.h
Message-ID: <20050411164607.GD12136@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.8i
X-Spam-Report: *  1.1 NO_DNS_FOR_FROM Domain in From header has no MX or A DNS records
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make defconfig give the following error on ppc (gcc-4):

arch/ppc/syslib/open_pic.c:36: error: static declaration of ‘OpenPIC’ follows non-static declaration
arch/ppc/syslib/open_pic_defs.h:175: error: previous declaration of ‘OpenPIC’ was here

The following patch solves it.

Signed-Off-By: Benoit Boissinot <benoit.boissinot@ens-lyon.org>

--- ./arch/ppc/syslib/open_pic_defs.h.orig	2005-04-11 14:51:54.000000000 +0200
+++ ./arch/ppc/syslib/open_pic_defs.h	2005-04-11 14:52:45.000000000 +0200
@@ -172,9 +172,6 @@ struct OpenPIC {
     OpenPIC_Processor Processor[OPENPIC_MAX_PROCESSORS];
 };
 
-extern volatile struct OpenPIC __iomem *OpenPIC;
-
-
     /*
      *  Current Task Priority Register
      */
