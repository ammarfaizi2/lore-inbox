Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264649AbTE1KCD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 06:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264650AbTE1KCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 06:02:03 -0400
Received: from front1.netvisao.pt ([213.228.128.56]:62462 "HELO
	front1.netvisao.pt") by vger.kernel.org with SMTP id S264649AbTE1KCA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 06:02:00 -0400
Date: Wed, 28 May 2003 11:16:14 +0100
From: "Paulo Andre'" <fscked@iol.pt>
To: Jeff Smith <whydoubt@yahoo.com>
Cc: linux-kernel@vger.kernel.org, mec@shout.net
Subject: Re: [PATCH] KBuild documentation - make dep
Message-Id: <20030528111614.4e9b474f.fscked@iol.pt>
In-Reply-To: <20030528050819.14176.qmail@web40009.mail.yahoo.com>
References: <20030528002825.43994e24.fscked@iol.pt>
	<20030528050819.14176.qmail@web40009.mail.yahoo.com>
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Wed__28_May_2003_11:16:14_+0100_082cbec8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Wed__28_May_2003_11:16:14_+0100_082cbec8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 May 2003 22:08:19 -0700 (PDT)
Jeff Smith <whydoubt@yahoo.com> wrote:

>
> Paulo,
> I would say make dep was deprecated around 2.5.23.  In 2.5.60, in the
> root Makefile, the target was reduced to a simple warning.  I would
> call this'obsoleted'.  As far as I can tell, only one Makefile still
> utilizes the dep target, and this may be an oversight.  So how about
> this patch:

Thanks for the insight, wasn't aware of the exact versions. Following
that, I've elaborated it just a bit more. What do you think?

		Paulo


--Multipart_Wed__28_May_2003_11:16:14_+0100_082cbec8
Content-Type: text/plain;
 name="kbuild-commands.txt.patch"
Content-Disposition: attachment;
 filename="kbuild-commands.txt.patch"
Content-Transfer-Encoding: 7bit

--- linux-2.5-vanilla/Documentation/kbuild/commands.txt	2003-03-24 22:00:50.000000000 +0000
+++ linux/Documentation/kbuild/commands.txt	2003-05-28 11:12:48.000000000 +0100
@@ -91,23 +91,8 @@
 
 	'make dep' is a synonym for the long form, 'make depend'.
 
-	This command does two things.  First, it computes dependency
-	information about which .o files depend on which .h files.
-	It records this information in a top-level file named .hdepend
-	and in one file per source directory named .depend.
-
-	Second, if you have CONFIG_MODVERSIONS enabled, 'make dep'
-	computes symbol version information for all of the files that
-	export symbols (note that both resident and modular files may
-	export symbols).
-
-	If you do not enable CONFIG_MODVERSIONS, you only have to run
-	'make dep' once, right after the first time you configure
-	the kernel.  The .hdepend files and the .depend file are
-	independent of your configuration.
-
-	If you do enable CONFIG_MODVERSIONS, you must run 'make dep'
-	every time you change your configuration, because the module
-	symbol version information depends on the configuration.
+	As a visible side effect of the new kbuild system, 'make dep'
+	is no longer needed at any build stage anymore. As of version
+	2.5.60 this target has actually become obsolete.
 
 [to be continued ...]

--Multipart_Wed__28_May_2003_11:16:14_+0100_082cbec8--
