Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265490AbUFOMOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265490AbUFOMOK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 08:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265492AbUFOMOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 08:14:10 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:41360 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S265490AbUFOMOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 08:14:07 -0400
Message-Id: <200406151213.i5FCDg8M003141@eeyore.valparaiso.cl>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 5/5] kbuild: external module build doc 
In-Reply-To: Message from Sam Ravnborg <sam@ravnborg.org> 
   of "Mon, 14 Jun 2004 22:48:09 +0200." <20040614204809.GF15243@mars.ravnborg.org> 
X-Mailer: MH-E 7.4.2; nmh 1.0.4; XEmacs 21.4 (patch 14)
Date: Tue, 15 Jun 2004 08:13:39 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> said:
> # This is a BitKeeper generated diff -Nru style patch.
> #
> # ChangeSet
> #   2004/06/14 22:21:46+02:00 sam@mars.ravnborg.org 

[...]

> --- /dev/null	Wed Dec 31 16:00:00 196900
> +++ b/Documentation/kbuild/extmodules.txt	2004-06-14 22:25:21 +02:00
> @@ -0,0 +1,168 @@
> +Building external modules
> +=========================
> +kbuild offers functionality to build external modules, with the
> +prerequisite that there is a pre-built kernel avialable with full source.

No. It should be enough to have run "make modules_prepare".

> +A subset of the targets available when building the kernel is available
> +when building an external module.
> +
> +
> +Building the module
> +-------------------
> +The command looks like his:
> +
> +	make -C <path to kernel src> M=`pwd`

For me, it works with:

  make -C <path to kernel src> SUBDIRS=<path to module source> modules
     # Builds
  make -C <path to kernel src> SUBDIRS=<path to module source> modules_install
     # Installs

Besides, IMHO this belongs in Documentation/kbuild/modules.txt.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
