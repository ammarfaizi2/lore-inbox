Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261640AbVFLOMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbVFLOMK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 10:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVFLOMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 10:12:10 -0400
Received: from aun.it.uu.se ([130.238.12.36]:33186 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261640AbVFLOMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 10:12:07 -0400
Date: Sun, 12 Jun 2005 16:11:49 +0200 (MEST)
Message-Id: <200506121411.j5CEBnUr020043@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de
Subject: Re: [PATCH 2.4.31 6/9] gcc4: fix x86_64 sys_iopl() bug
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi wrote:
> > @@ -113,9 +113,18 @@ quiet_ni_syscall:
> >  	PTREGSCALL stub32_fork, sys32_fork
> >  	PTREGSCALL stub32_clone, sys32_clone
> >  	PTREGSCALL stub32_vfork, sys32_vfork
> > -	PTREGSCALL stub32_iopl, sys_iopl
> >  	PTREGSCALL stub32_rt_sigsuspend, sys_rt_sigsuspend
> >  
> > +	.macro PTREGSCALL3 label, func, arg
> 
> PTREGSCALL3? I'm sure that is not in 2.6. How about just changing
> PTREGSCALL globally? 

Well I renamed it so that I could use it _only_ for the required
syscalls, i.e. sys_iopl(). I can change all of them if you feel
that's more appropriate.

/Mikael
