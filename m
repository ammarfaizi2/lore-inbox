Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264490AbTE1EzG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 00:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264507AbTE1EzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 00:55:06 -0400
Received: from web40009.mail.yahoo.com ([66.218.78.27]:21515 "HELO
	web40009.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264490AbTE1EzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 00:55:04 -0400
Message-ID: <20030528050819.14176.qmail@web40009.mail.yahoo.com>
Date: Tue, 27 May 2003 22:08:19 -0700 (PDT)
From: Jeff Smith <whydoubt@yahoo.com>
Subject: Re: [PATCH] KBuild documentation - make dep
To: "Paulo Andre'" <fscked@iol.pt>
Cc: linux-kernel@vger.kernel.org, mec@shout.net
In-Reply-To: <20030528002825.43994e24.fscked@iol.pt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Paulo Andre' <fscked@iol.pt> wrote:
> On Tue, 27 May 2003 10:44:53 -0700 (PDT)
> Jeff Smith <whydoubt@yahoo.com> wrote:
> 
> Perhaps a reference saying that `make dep' is not needed anymore and
> that it is actually deprecated should remain in the documentation?
> 
> 		Paulo

Paulo,
I would say make dep was deprecated around 2.5.23.  In 2.5.60, in the root
Makefile, the target was reduced to a simple warning.  I would call this
'obsoleted'.  As far as I can tell, only one Makefile still utilizes the
dep target, and this may be an oversight.  So how about this patch:

-- Jeff Smith

========================================================================
--- a/Documentation/kbuild/commands.txt Mon May 26 20:00:41 2003
+++ b/Documentation/kbuild/commands.txt Tue May 27 23:39:29 2003
@@ -17,7 +17,6 @@
 you need:

     make config
-    make dep
     make bzImage

 Instead of 'make config', you can run 'make menuconfig' for a full-screen
@@ -91,23 +90,6 @@

        'make dep' is a synonym for the long form, 'make depend'.

-       This command does two things.  First, it computes dependency
-       information about which .o files depend on which .h files.
-       It records this information in a top-level file named .hdepend
-       and in one file per source directory named .depend.
-
-       Second, if you have CONFIG_MODVERSIONS enabled, 'make dep'
-       computes symbol version information for all of the files that
-       export symbols (note that both resident and modular files may
-       export symbols).
-
-       If you do not enable CONFIG_MODVERSIONS, you only have to run
-       'make dep' once, right after the first time you configure
-       the kernel.  The .hdepend files and the .depend file are
-       independent of your configuration.
-
-       If you do enable CONFIG_MODVERSIONS, you must run 'make dep'
-       every time you change your configuration, because the module
-       symbol version information depends on the configuration.
+       As of version 2.5.60, this command is obsolete.

 [to be continued ...]


__________________________________
Do you Yahoo!?
Yahoo! Calendar - Free online calendar with sync to Outlook(TM).
http://calendar.yahoo.com
