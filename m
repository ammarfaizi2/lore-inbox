Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWF3VvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWF3VvZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 17:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbWF3VvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 17:51:25 -0400
Received: from ns1.suse.de ([195.135.220.2]:20643 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751144AbWF3VvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 17:51:24 -0400
Date: Fri, 30 Jun 2006 14:47:56 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Subject: Re: Linux 2.6.16.23
Message-ID: <20060630214756.GB12143@kroah.com>
References: <20060630214715.GA12143@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060630214715.GA12143@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 4b2bb08..da3e313 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 16
-EXTRAVERSION = .22
+EXTRAVERSION = .23
 NAME=Sliding Snow Leopard
 
 # *DOCUMENTATION*
diff --git a/drivers/parport/Kconfig b/drivers/parport/Kconfig
index 6c8452e..f63c387 100644
--- a/drivers/parport/Kconfig
+++ b/drivers/parport/Kconfig
@@ -48,7 +48,7 @@ config PARPORT_PC
 
 config PARPORT_SERIAL
 	tristate "Multi-IO cards (parallel and serial)"
-	depends on SERIAL_8250_PCI && PARPORT_PC && PCI
+	depends on SERIAL_8250 && PARPORT_PC && PCI
 	help
 	  This adds support for multi-IO PCI cards that have parallel and
 	  serial ports.  You should say Y or M here.  If you say M, the module
diff --git a/net/ipv4/netfilter/ip_conntrack_proto_sctp.c b/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
index df67679..b82be93 100644
--- a/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
+++ b/net/ipv4/netfilter/ip_conntrack_proto_sctp.c
@@ -254,7 +254,7 @@ static int do_basic_checks(struct ip_con
 	}
 
 	DEBUGP("Basic checks passed\n");
-	return 0;
+	return count == 0;
 }
 
 static int new_state(enum ip_conntrack_dir dir,
diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_conntrack_proto_sctp.c
index cd2326d..7fcd1dd 100644
--- a/net/netfilter/nf_conntrack_proto_sctp.c
+++ b/net/netfilter/nf_conntrack_proto_sctp.c
@@ -259,7 +259,7 @@ static int do_basic_checks(struct nf_con
 	}
 
 	DEBUGP("Basic checks passed\n");
-	return 0;
+	return count == 0;
 }
 
 static int new_state(enum ip_conntrack_dir dir,
