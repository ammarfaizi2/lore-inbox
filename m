Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317191AbSGSXIf>; Fri, 19 Jul 2002 19:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317194AbSGSXIf>; Fri, 19 Jul 2002 19:08:35 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:15881 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317191AbSGSXId>;
	Fri, 19 Jul 2002 19:08:33 -0400
Date: Fri, 19 Jul 2002 16:10:01 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [BK PATCH] LSM task control for 2.5.26
Message-ID: <20020719231000.GB24044@kroah.com>
References: <20020719230936.GA24044@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020719230936.GA24044@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Fri, 21 Jun 2002 22:08:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.660   -> 1.661  
#	include/linux/sysctl.h	1.18    -> 1.19   
#	arch/arm/kernel/isa.c	1.1     -> 1.2    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/19	greg@kroah.com	1.661
# LSM: change BUS_ISA to CTL_BUS_ISA to prevent namespace collision with the input subsystem.
# 
# This is needed due to the next header file changes.
# --------------------------------------------
#
diff -Nru a/arch/arm/kernel/isa.c b/arch/arm/kernel/isa.c
--- a/arch/arm/kernel/isa.c	Fri Jul 19 16:03:52 2002
+++ b/arch/arm/kernel/isa.c	Fri Jul 19 16:03:52 2002
@@ -38,7 +38,7 @@
 
 static struct ctl_table_header *isa_sysctl_header;
 
-static ctl_table ctl_isa[2] = {{BUS_ISA, "isa", NULL, 0, 0555, ctl_isa_vars},
+static ctl_table ctl_isa[2] = {{CTL_BUS_ISA, "isa", NULL, 0, 0555, ctl_isa_vars},
 			       {0}};
 static ctl_table ctl_bus[2] = {{CTL_BUS, "bus", NULL, 0, 0555, ctl_isa},
 			       {0}};
diff -Nru a/include/linux/sysctl.h b/include/linux/sysctl.h
--- a/include/linux/sysctl.h	Fri Jul 19 16:03:52 2002
+++ b/include/linux/sysctl.h	Fri Jul 19 16:03:52 2002
@@ -72,7 +72,7 @@
 /* CTL_BUS names: */
 enum
 {
-	BUS_ISA=1		/* ISA */
+	CTL_BUS_ISA=1		/* ISA */
 };
 
 /* CTL_KERN names: */
