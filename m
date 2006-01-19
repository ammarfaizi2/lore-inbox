Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161453AbWASWEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161453AbWASWEo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 17:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161452AbWASWEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 17:04:44 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:40412
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1161449AbWASWEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 17:04:42 -0500
Date: Thu, 19 Jan 2006 14:04:31 -0800
From: Greg KH <greg@kroah.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, geert@linux-m68k.org, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: License oddity in some m68k files
Message-ID: <20060119220431.GA4739@kroah.com>
References: <20060119180947.GA25001@kroah.com> <Pine.LNX.4.61.0601192014010.30994@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0601192014010.30994@scrub.home>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 09:14:09PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Thu, 19 Jan 2006, Greg KH wrote:
> 
> > Someone recently pointed out to me the following wording on some of the
> > m68k files that reads:
> > 
> > |               Copyright (C) Motorola, Inc. 1990
> > |                       All Rights Reserved
> > |
> > |       THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
> > |       The copyright notice above does not evidence any
> > |       actual or intended publication of such source code.
> 
> It has been published like this from Motorola and still is available at
> http://www.freescale.com/files/32bit/software/app_software/code_examples/MC68040FPSP.html
> 
> > Any ideas of how they made it into our tree?  And any chance of
> > correcting them to be the correct license or removing them?
> 
> The above is only a copyright notice, does this already constitute a 
> license?

No, it doesn't, but the UNPUBLISHED portion sure makes people wonder
about it.

> The actual license is in the README file.

Ah, ok, thanks, that makes sense.  How about a simple pointer to the
license info from the .S files to the README file so that people (like
me), don't get confused again?  I've attached a patch below if you wish
to apply it.

thanks,

greg k-h


-------------
From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH] Add wording to m68k .S files to help clairfy license info.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

 arch/m68k/fpsp040/bindec.S     |    3 +++
 arch/m68k/fpsp040/binstr.S     |    3 +++
 arch/m68k/fpsp040/bugfix.S     |    3 +++
 arch/m68k/fpsp040/decbin.S     |    3 +++
 arch/m68k/fpsp040/do_func.S    |    3 +++
 arch/m68k/fpsp040/gen_except.S |    3 +++
 arch/m68k/fpsp040/get_op.S     |    3 +++
 arch/m68k/fpsp040/kernel_ex.S  |    3 +++
 arch/m68k/fpsp040/res_func.S   |    3 +++
 arch/m68k/fpsp040/round.S      |    3 +++
 arch/m68k/fpsp040/sacos.S      |    3 +++
 arch/m68k/fpsp040/sasin.S      |    3 +++
 arch/m68k/fpsp040/satan.S      |    3 +++
 arch/m68k/fpsp040/satanh.S     |    3 +++
 arch/m68k/fpsp040/scale.S      |    3 +++
 arch/m68k/fpsp040/scosh.S      |    3 +++
 arch/m68k/fpsp040/setox.S      |    3 +++
 arch/m68k/fpsp040/sgetem.S     |    3 +++
 arch/m68k/fpsp040/sint.S       |    3 +++
 arch/m68k/fpsp040/skeleton.S   |    3 +++
 arch/m68k/fpsp040/slog2.S      |    3 +++
 arch/m68k/fpsp040/slogn.S      |    3 +++
 arch/m68k/fpsp040/smovecr.S    |    3 +++
 arch/m68k/fpsp040/srem_mod.S   |    3 +++
 arch/m68k/fpsp040/ssin.S       |    3 +++
 arch/m68k/fpsp040/ssinh.S      |    3 +++
 arch/m68k/fpsp040/stan.S       |    3 +++
 arch/m68k/fpsp040/stanh.S      |    3 +++
 arch/m68k/fpsp040/sto_res.S    |    3 +++
 arch/m68k/fpsp040/stwotox.S    |    3 +++
 arch/m68k/fpsp040/tbldo.S      |    3 +++
 arch/m68k/fpsp040/util.S       |    3 +++
 arch/m68k/fpsp040/x_bsun.S     |    3 +++
 arch/m68k/fpsp040/x_fline.S    |    3 +++
 arch/m68k/fpsp040/x_operr.S    |    3 +++
 arch/m68k/fpsp040/x_ovfl.S     |    3 +++
 arch/m68k/fpsp040/x_snan.S     |    3 +++
 arch/m68k/fpsp040/x_store.S    |    3 +++
 arch/m68k/fpsp040/x_unfl.S     |    3 +++
 arch/m68k/fpsp040/x_unimp.S    |    3 +++
 arch/m68k/fpsp040/x_unsupp.S   |    3 +++
 41 files changed, 123 insertions(+)

--- gregkh-2.6.orig/arch/m68k/fpsp040/bindec.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/bindec.S	2006-01-19 13:59:58.000000000 -0800
@@ -134,6 +134,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 |BINDEC    idnt    2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/binstr.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/binstr.S	2006-01-19 13:59:47.000000000 -0800
@@ -63,6 +63,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 |BINSTR    idnt    2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/bugfix.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/bugfix.S	2006-01-19 13:59:55.000000000 -0800
@@ -155,6 +155,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 |BUGFIX    idnt    2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/decbin.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/decbin.S	2006-01-19 14:00:06.000000000 -0800
@@ -72,6 +72,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 |DECBIN    idnt    2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/do_func.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/do_func.S	2006-01-19 14:00:11.000000000 -0800
@@ -25,6 +25,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 DO_FUNC:	|idnt    2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/gen_except.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/gen_except.S	2006-01-19 14:00:17.000000000 -0800
@@ -32,6 +32,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 GEN_EXCEPT:    |idnt    2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/get_op.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/get_op.S	2006-01-19 14:00:21.000000000 -0800
@@ -57,6 +57,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 GET_OP:    |idnt    2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/kernel_ex.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/kernel_ex.S	2006-01-19 14:00:25.000000000 -0800
@@ -15,6 +15,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 KERNEL_EX:    |idnt    2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/res_func.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/res_func.S	2006-01-19 14:00:29.000000000 -0800
@@ -19,6 +19,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 RES_FUNC:    |idnt    2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/round.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/round.S	2006-01-19 14:00:34.000000000 -0800
@@ -11,6 +11,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 |ROUND	idnt    2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/sacos.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/sacos.S	2006-01-19 14:00:38.000000000 -0800
@@ -41,6 +41,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 |SACOS	idnt	2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/sasin.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/sasin.S	2006-01-19 14:00:43.000000000 -0800
@@ -41,6 +41,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 |SASIN	idnt	2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/satan.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/satan.S	2006-01-19 14:00:48.000000000 -0800
@@ -46,6 +46,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 |satan	idnt	2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/satanh.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/satanh.S	2006-01-19 14:00:52.000000000 -0800
@@ -48,6 +48,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 |satanh	idnt	2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/scale.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/scale.S	2006-01-19 14:00:56.000000000 -0800
@@ -24,6 +24,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 |SCALE    idnt    2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/scosh.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/scosh.S	2006-01-19 14:01:01.000000000 -0800
@@ -52,6 +52,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 |SCOSH	idnt	2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/setox.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/setox.S	2006-01-19 14:01:05.000000000 -0800
@@ -334,6 +334,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 |setox	idnt	2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/sgetem.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/sgetem.S	2006-01-19 14:01:09.000000000 -0800
@@ -27,6 +27,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 |SGETEM	idnt	2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/sint.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/sint.S	2006-01-19 14:01:13.000000000 -0800
@@ -54,6 +54,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 |SINT    idnt    2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/skeleton.S	2006-01-17 08:25:48.000000000 -0800
+++ gregkh-2.6/arch/m68k/fpsp040/skeleton.S	2006-01-19 14:01:17.000000000 -0800
@@ -33,6 +33,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 |
 |	Modified for Linux-1.3.x by Jes Sorensen (jds@kom.auc.dk)
--- gregkh-2.6.orig/arch/m68k/fpsp040/slog2.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/slog2.S	2006-01-19 14:01:21.000000000 -0800
@@ -99,6 +99,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 |SLOG2    idnt    2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/slogn.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/slogn.S	2006-01-19 14:01:24.000000000 -0800
@@ -66,6 +66,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 |slogn	idnt	2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/smovecr.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/smovecr.S	2006-01-19 14:01:28.000000000 -0800
@@ -18,6 +18,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 |SMOVECR	idnt	2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/srem_mod.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/srem_mod.S	2006-01-19 14:01:32.000000000 -0800
@@ -69,6 +69,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 SREM_MOD:    |idnt    2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/ssin.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/ssin.S	2006-01-19 14:01:35.000000000 -0800
@@ -86,6 +86,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 |SSIN	idnt	2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/ssinh.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/ssinh.S	2006-01-19 14:01:40.000000000 -0800
@@ -52,6 +52,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 |SSINH	idnt	2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/stan.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/stan.S	2006-01-19 14:01:44.000000000 -0800
@@ -53,6 +53,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 |STAN	idnt	2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/stanh.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/stanh.S	2006-01-19 14:01:49.000000000 -0800
@@ -52,6 +52,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 |STANH	idnt	2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/sto_res.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/sto_res.S	2006-01-19 14:01:53.000000000 -0800
@@ -22,6 +22,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 STO_RES:	|idnt	2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/stwotox.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/stwotox.S	2006-01-19 14:01:57.000000000 -0800
@@ -79,6 +79,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 |STWOTOX	idnt	2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/tbldo.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/tbldo.S	2006-01-19 14:02:00.000000000 -0800
@@ -20,6 +20,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 |TBLDO	idnt    2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/util.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/util.S	2006-01-19 14:02:04.000000000 -0800
@@ -19,6 +19,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 |UTIL	idnt    2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/x_bsun.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/x_bsun.S	2006-01-19 14:02:07.000000000 -0800
@@ -16,6 +16,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 X_BSUN:	|idnt    2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/x_fline.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/x_fline.S	2006-01-19 14:02:11.000000000 -0800
@@ -16,6 +16,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 X_FLINE:	|idnt    2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/x_operr.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/x_operr.S	2006-01-19 14:02:15.000000000 -0800
@@ -46,6 +46,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 X_OPERR:	|idnt    2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/x_ovfl.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/x_ovfl.S	2006-01-19 14:02:20.000000000 -0800
@@ -38,6 +38,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 X_OVFL:	|idnt    2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/x_snan.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/x_snan.S	2006-01-19 14:02:23.000000000 -0800
@@ -25,6 +25,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 X_SNAN:	|idnt    2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/x_store.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/x_store.S	2006-01-19 14:02:27.000000000 -0800
@@ -14,6 +14,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 X_STORE:	|idnt    2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/x_unfl.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/x_unfl.S	2006-01-19 14:02:30.000000000 -0800
@@ -24,6 +24,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 X_UNFL:	|idnt    2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/x_unimp.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/x_unimp.S	2006-01-19 14:02:33.000000000 -0800
@@ -25,6 +25,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 X_UNIMP:	|idnt    2,1 | Motorola 040 Floating Point Software Package
 
--- gregkh-2.6.orig/arch/m68k/fpsp040/x_unsupp.S	2005-10-27 17:02:08.000000000 -0700
+++ gregkh-2.6/arch/m68k/fpsp040/x_unsupp.S	2006-01-19 14:02:38.000000000 -0800
@@ -26,6 +26,9 @@
 |	THIS IS UNPUBLISHED PROPRIETARY SOURCE CODE OF MOTOROLA
 |	The copyright notice above does not evidence any
 |	actual or intended publication of such source code.
+|
+|	For details on the license for this file, please see the
+|	file, README, in this same directory.
 
 X_UNSUPP:	|idnt    2,1 | Motorola 040 Floating Point Software Package
 
