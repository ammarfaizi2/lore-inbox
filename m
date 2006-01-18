Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWARKpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWARKpd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 05:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbWARKpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 05:45:33 -0500
Received: from mail.gmx.net ([213.165.64.21]:46299 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964878AbWARKpc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 05:45:32 -0500
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] mempolicy.c compile fix
Date: Wed, 18 Jan 2006 11:45:32 +0100
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <20060118005053.118f1abc.akpm@osdl.org>
In-Reply-To: <20060118005053.118f1abc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_MxhzD6E5/QxQJVu"
Message-Id: <200601181145.32267.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_MxhzD6E5/QxQJVu
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday, 18. January 2006 09:50, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc1/=
2.
>6.16-rc1-mm1/

  CC      mm/mempolicy.o
mm/mempolicy.c:547: Fehler: Syntaxfehler vor =BB}=AB-Zeichen
make[1]: *** [mm/mempolicy.o] Fehler 1
make: *** [mm] Fehler 2

Patch attached.

greets,
dominik

--Boundary-00=_MxhzD6E5/QxQJVu
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="trivial_compile_fix_mempolicy.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="trivial_compile_fix_mempolicy.diff"

--- linux-2.6.11.5/mm/mempolicy.orig.c	2006-01-18 11:36:48.000000000 +0100
+++ linux-2.6.11.5/mm/mempolicy.c	2006-01-18 11:36:54.000000000 +0100
@@ -543,7 +543,6 @@
 	if ((flags & MPOL_MF_MOVE_ALL) || page_mapcount(page) ==1)
 		if (isolate_lru_page(page))
 			list_add(&page->lru, pagelist);
-	}
 }
 
 /*

--Boundary-00=_MxhzD6E5/QxQJVu--
