Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261446AbSJQO3N>; Thu, 17 Oct 2002 10:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261449AbSJQO3N>; Thu, 17 Oct 2002 10:29:13 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:31237 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261446AbSJQO3N>; Thu, 17 Oct 2002 10:29:13 -0400
Date: Thu, 17 Oct 2002 15:35:05 +0100
From: Christoph Hellwig <hch@infradead.org>
To: torvalds@transmeta.com, greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make LSM register functions GPLonly exports
Message-ID: <20021017153505.A27998@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	torvalds@transmeta.com, greg@kroah.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These exports have the power to change the implementations of all
syscalls and I've seen people exploiting this "feature".

Make the exports GPLonly (which some LSM folks agreed to
when it was merged initially to avoid that).

--- 1.2/security/security.c	Wed Aug 28 22:52:56 2002
+++ edited/security/security.c	Thu Oct 17 16:30:40 2002
@@ -241,9 +241,9 @@
 	return security_ops->sys_security (id, call, args);
 }
 
-EXPORT_SYMBOL (register_security);
-EXPORT_SYMBOL (unregister_security);
-EXPORT_SYMBOL (mod_reg_security);
-EXPORT_SYMBOL (mod_unreg_security);
-EXPORT_SYMBOL (capable);
-EXPORT_SYMBOL (security_ops);
+EXPORT_SYMBOL_GPL(register_security);
+EXPORT_SYMBOL_GPL(unregister_security);
+EXPORT_SYMBOL_GPL(mod_reg_security);
+EXPORT_SYMBOL_GPL(mod_unreg_security);
+EXPORT_SYMBOL(capable);
+EXPORT_SYMBOL(security_ops);
