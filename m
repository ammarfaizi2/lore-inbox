Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbUBZB7N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 20:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262590AbUBZB7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 20:59:13 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:48795 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262596AbUBZB7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 20:59:10 -0500
Date: Thu, 26 Feb 2004 02:59:07 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Cc: netdev@oss.sgi.com
Subject: 2.6: net/core.c should export sysctl_optmem_max for modular IPV6
Message-ID: <20040226015907.GA10986@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	netdev@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

IPv6 built as a module fails (in 2.6 BitKeeper tree) because it cannot
link to sysctl_optmem_max, trivial patch:

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/02/26 02:00:09+01:00 matthias.andree@gmx.de 
#   EXPORT_SYMBOL(sysctl_optmem_max) to make IPv6 happy.
# 
# net/core/sock.c
#   2004/02/26 01:58:51+01:00 matthias.andree@gmx.de +1 -0
#   EXPORT_SYMBOL(sysctl_optmem_max) to make IPv6 happy.
# 
diff -Nru a/net/core/sock.c b/net/core/sock.c
--- a/net/core/sock.c	Thu Feb 26 02:49:06 2004
+++ b/net/core/sock.c	Thu Feb 26 02:49:06 2004
@@ -1186,6 +1186,7 @@
 EXPORT_SYMBOL(sock_wfree);
 EXPORT_SYMBOL(sock_wmalloc);
 #ifdef CONFIG_SYSCTL
+EXPORT_SYMBOL(sysctl_optmem_max);
 EXPORT_SYMBOL(sysctl_rmem_max);
 EXPORT_SYMBOL(sysctl_wmem_max);
 #endif

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
