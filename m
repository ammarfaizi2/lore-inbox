Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965209AbVINNsi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965209AbVINNsi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 09:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbVINNsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 09:48:38 -0400
Received: from mivlgu.ru ([81.18.140.87]:48585 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S965209AbVINNsi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 09:48:38 -0400
Date: Wed, 14 Sep 2005 17:48:31 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, joern@infradead.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Permanently fix kernel configuration include mess (was:
   Missing #include <config.h>)
Message-Id: <20050914174831.578d9f4c.vsu@altlinux.ru>
In-Reply-To: <20050914013944.5ee4efa7.akpm@osdl.org>
References: <20050913135622.GA30675@phoenix.infradead.org>
	<20050913150825.A23643@flint.arm.linux.org.uk>
	<20050913155012.C23643@flint.arm.linux.org.uk>
	<20050914013944.5ee4efa7.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.0beta4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Wed__14_Sep_2005_17_48_31_+0400_MA=nhylV3oBuXeyo"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Wed__14_Sep_2005_17_48_31_+0400_MA=nhylV3oBuXeyo
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Wed, 14 Sep 2005 01:39:44 -0700 Andrew Morton wrote:

> Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> >
> >  LINUXINCLUDE    := -Iinclude \
> >  -                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include)
> >  +                   $(if $(KBUILD_SRC),-Iinclude2 -I$(srctree)/include) \
> >  +		   -imacros include/linux/autoconf.h
> 
> This means that over time the kernel will fail to compile correctly without
> `-imacros include/linux/autoconf.h'.
> 
> That's OK for the kernel, but not for out-of-tree stuff.  Those drivers
> will need to add the new gcc commandline option too.

You mean out-of-tree drivers which don't use the kernel makefiles when
compiling for 2.6?  Are there such beasts, and do we care about them?

(For 2.4 such crap was almost everywhere; for 2.6 the situation seems
to be better.)

--Signature=_Wed__14_Sep_2005_17_48_31_+0400_MA=nhylV3oBuXeyo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDKCoxW82GfkQfsqIRAgOnAJwNAG/BPbmBrhvXTLkB/q2vyJvLhgCeOURI
NUAK5unVfHBuCgnrPGru/i4=
=ac2G
-----END PGP SIGNATURE-----

--Signature=_Wed__14_Sep_2005_17_48_31_+0400_MA=nhylV3oBuXeyo--
