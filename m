Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271146AbTHRAq3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 20:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271148AbTHRAq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 20:46:29 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:7387 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S271146AbTHRAq2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 20:46:28 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Jeff Garzik <jgarzik@pobox.com>
Subject: [PATCH] Re: make htmldocs is broken.
Date: Sun, 17 Aug 2003 20:46:22 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200308170618.35939.rob@landley.net> <3F3FEEAF.2070608@pobox.com>
In-Reply-To: <3F3FEEAF.2070608@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308172046.22362.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 August 2003 17:07, Jeff Garzik wrote:
> Rob Landley wrote:
> > Does this command live on default installs of SuSE or debian or
> > something? (Or maybe it was in RH 7 or so and has been removed?)
>
> Red Hat and Debian ship this program in their current distros, in the
> transfig package.
>
> 	Jeff

But it's not installed by default.  Okay...

How bout this one then? :)

>Working on: /home/landley/linux/linux-2.6.0-test3/Documentation/DocBook/sis900.sgml
>Done.
>  DOCPROC Documentation/DocBook/kernel-api.sgml
>docproc: kernel/pm.c: No such file or directory
>make[1]: *** [Documentation/DocBook/kernel-api.sgml] Error 139
>make: *** [htmldocs] Error 2

Possibly due to me upgrading to test3-bk5.  The following patch seems to
fix it, although there are 8 zillion warnings build everything from there on
down...

--- temp/Documentation/DocBook/kernel-api.tmpl  2003-08-17 20:40:39.000000000 -0400
+++ linux-2.6.0-test3/Documentation/DocBook/kernel-api.tmpl     2003-08-17 20:40:54.000000000 -0400
@@ -206,7 +206,7 @@

   <chapter id="pmfuncs">
      <title>Power Management</title>
-!Ekernel/pm.c
+!Ekernel/power/pm.c
   </chapter>

   <chapter id="blkdev">


Rob
