Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315629AbSGAOKR>; Mon, 1 Jul 2002 10:10:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315631AbSGAOKQ>; Mon, 1 Jul 2002 10:10:16 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:6721 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S315629AbSGAOKP>;
	Mon, 1 Jul 2002 10:10:15 -0400
Date: Mon, 1 Jul 2002 16:12:27 +0200
From: Sebastian Droege <sebastian.droege@gmx.de>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: davej@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove 16 unnecessary includes of sched.h
Message-Id: <20020701161227.3b6e7576.sebastian.droege@gmx.de>
In-Reply-To: <Pine.LNX.4.33.0207010035030.11868-100000@gans.physik3.uni-rostock.de>
References: <Pine.LNX.4.33.0207010035030.11868-100000@gans.physik3.uni-rostock.de>
X-Mailer: Sylpheed version 0.7.8 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.DgFeaYC50MkLMv"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.DgFeaYC50MkLMv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 1 Jul 2002 00:42:58 +0200 (CEST)
Tim Schmielau <tim@physik3.uni-rostock.de> wrote:

>  - remove 16 unneccessary #includes of <linux/sched.h>.
>  - reinsert some #includes of header files included by <linux/sched.h>
>    to fix indirect dependencies.
> 
> Just a small start, many more to come. This time I did a more thorough 
> analysis of dependencies by extensive use of ctags and grep. Still the 
> first compile revealed more obscure dependencies.
> 
> The patch depends on the previously posted one to break task_struct out of 
> sched.h to actually compile.
> 
> Tim
Hi,
The patch at the bottom was required to compile kernel/panic.c with my .config (NULL was not defined)

Bye

--- linux-2.5.24/include/linux/sysrq.h.old      Mon Jul  1 15:50:33 2002
+++ linux-2.5.24/include/linux/sysrq.h  Mon Jul  1 15:45:16 2002
@@ -12,6 +12,7 @@
  */
 
 #include <linux/config.h>
+#include <linux/stddef.h>
 
 struct pt_regs;
 struct kbd_struct;


--=.DgFeaYC50MkLMv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9IGNOe9FFpVVDScsRAtJFAKDHmHXM6KG4EJ+X23UfL++F4u24DQCg6bc3
UeOGSGJ+NZv2auEtsELqiLU=
=9zXM
-----END PGP SIGNATURE-----

--=.DgFeaYC50MkLMv--

