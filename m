Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbTIRNte (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 09:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbTIRNte
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 09:49:34 -0400
Received: from [193.138.115.2] ([193.138.115.2]:4362 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S261328AbTIRNta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 09:49:30 -0400
Date: Thu, 18 Sep 2003 15:44:45 +0200 (CEST)
From: Jesper Juhl <jju@dif.dk>
To: John Cherry <cherry@osdl.org>
cc: Randy Dunlap <rddunlap@osdl.org>, reg@dwf.com,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test5: "No module aic7xxx found for kernel 2.6.0-test5, 
 aborting."
In-Reply-To: <1063734412.20156.2.camel@cherrytest.pdx.osdl.net>
Message-ID: <Pine.LNX.4.56.0309181535580.10528@jju_lnx.backbone.dif.dk>
References: <200309130725.h8D7PE6d019675@orion.dwf.com> 
 <20030915095354.6f28eedd.rddunlap@osdl.org> <1063734412.20156.2.camel@cherrytest.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While not directly related to fixing the problems building the aic7xxx
driver I thought you might find these patches I did recently of
interrest since they also deal with aic7xxx, or rather with its
documentation (I've submitted these to lkml before, but they seemed to get
lost in the sea of email - probably in part because they are very
trivial).

I was hoping that since you are already working on aic7xxx you might
consider merging these while you where at it. If submitting the patches in
this manner is inappropriate I appologize.


diff -u linux-2.6.0-test5-orig/drivers/scsi/aic7xxx/Kconfig.aic79xx linux-2.6.0-test5/drivers/scsi/aic7xxx/Kconfig.aic79xx
--- linux-2.6.0-test5-orig/drivers/scsi/aic7xxx/Kconfig.aic79xx 2003-09-08 21:50:03.000000000 +0200
+++ linux-2.6.0-test5/drivers/scsi/aic7xxx/Kconfig.aic79xx      2003-09-15 23:32:06.000000000 +0200
@@ -66,7 +66,7 @@
        with read streaming enabled so it is disabled by default.  Read
        Streaming can be configured in much the same way as tagged
queueing
        using the "rd_strm" command line option.  See
-       drivers/scsi/aic7xxx/README.aic79xx for details.
+       <file:Documentation/scsi/aic79xx.txt> for details.

 config AIC79XX_DEBUG_ENABLE
        bool "Compile in Debugging Code"


diff -u linux-2.6.0-test5-orig/drivers/scsi/aic7xxx/Kconfig.aic7xxx
linux-2.6.0-test5/drivers/scsi/aic7xxx/Kconfig.aic7xxx
--- linux-2.6.0-test5-orig/drivers/scsi/aic7xxx/Kconfig.aic7xxx 2003-09-08 21:50:01.000000000 +0200
+++ linux-2.6.0-test5/drivers/scsi/aic7xxx/Kconfig.aic7xxx      2003-09-15 22:00:34.000000000 +0200
@@ -36,7 +36,7 @@
        on some devices.  The upper bound is 253.  0 disables tagged
queueing.

        Per device tag depth can be controlled via the kernel command line
-       "tag_info" option.  See drivers/scsi/aic7xxx/README.aic7xxx
+       "tag_info" option.  See <file:Documentation/scsi/aic7xxx.txt>
        for details.

 config AIC7XXX_RESET_DELAY_MS


diff -u linux-2.6.0-test5-orig/Documentation/scsi/aic79xx.txt linux-2.6.0-test5/Documentation/scsi/aic79xx.txt
--- linux-2.6.0-test5-orig/Documentation/scsi/aic79xx.txt       2003-09-08 21:50:18.000000000 +0200
+++ linux-2.6.0-test5/Documentation/scsi/aic79xx.txt    2003-09-14 16:12:08.000000000 +0200
@@ -141,7 +141,7 @@
               Option: global_tag_depth
           Definition: Global tag depth for all targets on all busses.
                       This option sets the default tag depth which
-                      may be selectively overridden vi the tag_info
+                      may be selectively overridden via the tag_info
                       option.
      Possible Values: 1 - 253
        Default Value: 32


diff -u linux-2.6.0-test5-orig/Documentation/scsi/aic7xxx.txt linux-2.6.0-test5/Documentation/scsi/aic7xxx.txt
--- linux-2.6.0-test5-orig/Documentation/scsi/aic7xxx.txt       2003-09-08 21:49:58.000000000 +0200
+++ linux-2.6.0-test5/Documentation/scsi/aic7xxx.txt    2003-09-14 16:11:45.000000000 +0200
@@ -225,7 +225,7 @@
               Option: global_tag_depth:[value]
           Definition: Global tag depth for all targets on all busses.
                       This option sets the default tag depth which
-                      may be selectively overridden vi the tag_info
+                      may be selectively overridden via the tag_info
                       option.
      Possible Values: 1 - 253
        Default Value: 32



Kind regards,

Jesper Juhl <jju@dif.dk>

