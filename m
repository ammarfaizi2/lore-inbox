Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262817AbTKNSL6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 13:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbTKNSL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 13:11:58 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:3520 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S262817AbTKNSL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 13:11:56 -0500
Date: Fri, 14 Nov 2003 12:11:42 -0600
From: Jack Steiner <steiner@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: kiran@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: hot cache line due to note_interrupt()
Message-ID: <20031114181142.GA12143@sgi.com>
References: <20031110215844.GC21632@sgi.com> <20031111082915.GC1130@llm08.in.ibm.com> <20031111115804.4aaafd28.akpm@osdl.org> <20031114174535.GA30388@sgi.com> <20031114095737.40439f2c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031114095737.40439f2c.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 14, 2003 at 09:57:37AM -0800, Andrew Morton wrote:
> Jack Steiner <steiner@sgi.com> wrote:
> >
> > Probably too late for 2.6.0
> 
> Hard to see how it can break anything; I'll queue it up, thanks.
> 
> > but here is a patch that disables noirqdebug:
> 
> No update to Documentation/kernel-parameters.txt!  No cookie for you.

Do I get my cookie now  :-)


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1439  -> 1.1440 
#	Documentation/kernel-parameters.txt	1.31    -> 1.32   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/11/14	steiner@attica.americas.sgi.com	1.1440
# Update documentation for irqdebug.
# --------------------------------------------
#
diff -Nru a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	Fri Nov 14 12:09:40 2003
+++ b/Documentation/kernel-parameters.txt	Fri Nov 14 12:09:40 2003
@@ -427,6 +427,9 @@
 	ips=		[HW,SCSI] Adaptec / IBM ServeRAID controller
 			See header of drivers/scsi/ips.c.
 
+	irqdebug	[IA-32] Enables the code which attempts to detect and
+			disable unhandled interrupt sources.
+
 	isapnp=		[ISAPNP]
 			Format: <RDP>, <reset>, <pci_scan>, <verbosity>
 
@@ -624,9 +627,6 @@
 	no-hlt		[BUGS=IA-32] Tells the kernel that the hlt
 			instruction doesn't work correctly and not to
 			use it.
-
-	noirqdebug	[IA-32] Disables the code which attempts to detect and
-			disable unhandled interrupt sources.
 
 	noisapnp	[ISAPNP] Disables ISA PnP code.
 
-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.


