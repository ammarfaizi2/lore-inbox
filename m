Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268359AbUHQTNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268359AbUHQTNJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 15:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266615AbUHQTNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 15:13:09 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:13321 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S266610AbUHQTMw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 15:12:52 -0400
Date: Tue, 17 Aug 2004 23:12:58 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Coywolf Qi Hunt <coywolf@greatcn.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, akpm@osdl.org, kai@tp1.ruhr-uni-bochum.de,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] remove obsolete HEAD in kbuild
Message-ID: <20040817211258.GA20246@mars.ravnborg.org>
Mail-Followup-To: Coywolf Qi Hunt <coywolf@greatcn.org>,
	Sam Ravnborg <sam@ravnborg.org>, akpm@osdl.org,
	kai@tp1.ruhr-uni-bochum.de, linux-kernel@vger.kernel.org
References: <411F3A48.2030201@greatcn.org> <20040815174915.GA7265@mars.ravnborg.org> <412016AA.6030006@greatcn.org> <20040816205230.GA21047@mars.ravnborg.org> <41218562.9040204@greatcn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41218562.9040204@greatcn.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 12:11:14PM +0800, Coywolf Qi Hunt wrote:
> Sam Ravnborg wrote:
> 
> >On Mon, Aug 16, 2004 at 10:06:34AM +0800, Coywolf Qi Hunt wrote:
> > 
> >
> >>diff -Nrup linux-2.6.8/arch/cris/Makefile 
> >>linux-2.6.8-cy/arch/cris/Makefile
> >>--- linux-2.6.8/arch/cris/Makefile	2004-08-15 20:58:18.673278888 -0400
> >>+++ linux-2.6.8-cy/arch/cris/Makefile	2004-08-15 
> >>20:59:30.109679014 -0400
> >>@@ -39,8 +39,6 @@ CFLAGS := $(subst -fomit-frame-pointer,,
> >>CFLAGS += -fno-omit-frame-pointer
> >>endif
> >>
> >>-HEAD := arch/$(ARCH)/$(SARCH)/kernel/head.o
> >>-
> >>LIBGCC = $(shell $(CC) $(CFLAGS) -print-file-name=libgcc.a)
> >>
> >>core-y		+= arch/$(ARCH)/kernel/ arch/$(ARCH)/mm/
> >>   
> >>
> >
> >When you remove assignment to HEAD you need to replace 
> >it with assignment to head-y.
> >
> 
> No, we needn't. Some archs do not have head-y. They use core-y for head.o .
Looked and could not find it...
Adding head.o to extra-y does not get it compiled in.
To compile it in it needs to be listed in obj-y, and do not
confuse the three different head.S files.

	Sam
