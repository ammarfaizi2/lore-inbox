Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTIUCyx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 22:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbTIUCyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 22:54:52 -0400
Received: from h-69-3-93-149.SNVACAID.covad.net ([69.3.93.149]:32488 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S262273AbTIUCyv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 22:54:51 -0400
Date: Sat, 20 Sep 2003 18:51:26 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200309210151.h8L1pQA00853@freya.yggdrasil.com>
To: sam@ravnborg.org
Subject: Re: linux-2.6.0-test5/drivers/eisa verbose build failure
Cc: ink@jurassic.park.msu.ru, linux-kernel@vger.kernel.org,
       maz@wild-wind.fr.eu.org, mec@shout.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Sep 2003 13:29:12 +0200, Sam Ravnborg:
[...]
>The following patch fixes it for me.
>Would you mind trying this and report back.

>	Sam

>===== scripts/Makefile.lib 1.20 vs edited =====
>--- 1.20/scripts/Makefile.lib	Sun Jun  8 20:06:56 2003
>+++ edited/scripts/Makefile.lib	Sat Sep 20 09:11:28 2003
>@@ -225,7 +225,7 @@
> 
> # If quiet is set, only print short version of command
> 
>-cmd = @$(if $($(quiet)cmd_$(1)),echo '  $($(quiet)cmd_$(1))' &&) $(cmd_$(1))
>+cmd = @$(if $($(quiet)cmd_$(1)),echo '  $(subst ','\'',$($(quiet)cmd_$(1)))' &&) $(cmd_$(1))
> 
> #	$(call descend,<dir>,<target>)
> #	Recursively call a sub-make in <dir> with target <target> 

Thank you for the patch.  It seems to fix the problem for me.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
