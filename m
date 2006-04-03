Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWDCSKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWDCSKB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 14:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964831AbWDCSKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 14:10:00 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:18866 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S964827AbWDCSKA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 14:10:00 -0400
Message-Id: <200604031809.k33I9nYn032750@laptop11.inf.utfsm.cl>
To: Jiri Slaby <jirislaby@gmail.com>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sds@tycho.nsa.gov, jmorris@namei.org, selinux@tycho.nsa.gov
Subject: Re: 2.6.17-rc1 compile failure 
In-Reply-To: Message from Jiri Slaby <jirislaby@gmail.com> 
   of "Mon, 03 Apr 2006 17:15:56 +0159." <44313C43.7070701@gmail.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
Date: Mon, 03 Apr 2006 14:09:49 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.21.155]); Mon, 03 Apr 2006 14:09:44 -0400 (CLT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby <jirislaby@gmail.com> wrote:
> Horst von Brand napsal(a):
> > It ends with:
> > 
> >   CC      security/selinux/xfrm.o
> >   security/selinux/xfrm.c: In function â??selinux_socket_getpeer_dgramâ??:
> >   security/selinux/xfrm.c:284: error: â??struct sec_pathâ?? has no member named â??xâ??
> >   security/selinux/xfrm.c: In function â??selinux_xfrm_sock_rcv_skbâ??:
> >   security/selinux/xfrm.c:317: error: â??struct sec_pathâ?? has no member named â??xâ??
> >   make[2]: *** [security/selinux/xfrm.o] Error 1
> Could you test attached patch?
> 
> thanks,
> - --
> Jiri Slaby         www.fi.muni.cz/~xslaby
> \_.-^-._   jirislaby@gmail.com   _.-^-._/
> B67499670407CE62ACC8 22A032CC55C339D47A7E
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.2.2 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org
> 
> iD8DBQFEMTxDMsxVwznUen4RAgLCAJ9WEAU018cecP1emeMZKfCTrttVeQCgric6
> g9Cq+yh5IvmVJGHqlVsIEXs=
> =9MLb
> -----END PGP SIGNATURE-----
> SELinux-xfrm-compilation-fix
> 
> sec_path struct no longer contains sec_decap_state struct, but only
> xfrm_state.
> 
> Signed-off-by: Jiri Slaby <jirislaby@gmail.com>

Yep, that got it to build. Thanks!
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
