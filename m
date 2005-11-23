Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbVKWTJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbVKWTJq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:09:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbVKWTJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:09:46 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:7828 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S932204AbVKWTJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:09:45 -0500
Date: Wed, 23 Nov 2005 20:11:34 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Bodo Eggert <7eggert@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Makefile: Add modules-collect target
In-Reply-To: <20051123183357.GB8336@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.58.0511232003090.7020@be1.lrz>
References: <Pine.LNX.4.58.0511231915340.5759@be1.lrz>
 <20051123183357.GB8336@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2005, Sam Ravnborg wrote:
> On Wed, Nov 23, 2005 at 07:29:37PM +0100, Bodo Eggert wrote:

> > I frequently (but not frequently enough) compile kernels on one machine 
> > that are to be used on another machine. If It needs modules, I will need a 
> > way to collect all modules that need to be transfered into a directory.
> > Usurally I'll want INSTALL_MOD_PATH=somedir make modules_install, but I
> > keep forgetting the name of the variable. I suppose I'm not the only one.
> > 
> > Therefore I suggest a modules_collect target, which will collect all 
> > modules into a single directory ready for being tared and transfered:
> 
> If you keep forgetting the variable name why not put the variable name
> in the help instead of adding a new target?

Because I'm lazy. I think you may be right:

Signed-Off-By: Bodo Eggert <7eggert@gmx.de>

--- Makefile.orig	2005-11-23 20:07:17.000000000 +0100
+++ Makefile	2005-11-23 20:08:09.000000000 +0100
@@ -1065,5 +1065,5 @@ help:
 	@echo  '* vmlinux	  - Build the bare kernel'
 	@echo  '* modules	  - Build all modules'
-	@echo  '  modules_install - Install all modules'
+	@echo  '  modules_install - Install all modules to INSTALL_MOD_PATH (default: /)'
 	@echo  '  dir/            - Build all files in dir and below'
 	@echo  '  dir/file.[ois]  - Build specified target only'

-- 
Top 100 things you don't want the sysadmin to say:
79. What's this "any" key I'm supposed to press?
