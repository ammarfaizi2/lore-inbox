Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269635AbVBEVJS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269635AbVBEVJS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 16:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269670AbVBEVJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 16:09:17 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:17618 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S268981AbVBEVJA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 16:09:00 -0500
Subject: Missing Select in NFS server support causes comile error
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: SoftwareSuspend Development 
	<softwaresuspend-devel@lists.berlios.de>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1107637875.6348.22.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sun, 06 Feb 2005 08:11:15 +1100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This was picked up by a Suspend2 user.

Regards,

Nigel

-----Forwarded Message-----
> From: Peter Frühberger <Peter.Fruehberger@t-online.de>
> > I get an error while compiling, the same config worked for earlier 
> > releases for 2.6.11-rc2.
> > applied patches:
> > 2.6.11-rc3
> > swsusp2 2.1.6 for 2.6.11-rc3
> > OS: debian unstable
> > gcc version: gcc (GCC) 3.3.5 (Debian 1:3.3.5-8)
> > 
> >   LD      init/built-in.o
> >   LD      .tmp_vmlinux1
> > fs/built-in.o(.text+0x7329f): In function `fh_verify':
> > : undefined reference to `export_op_default'
> > fs/built-in.o(.text+0x738b7): In function `fh_compose':
> > : undefined reference to `export_op_default'
> > fs/built-in.o(.text+0x73bb7): In function `fh_update':
> > : undefined reference to `export_op_default'
> > fs/built-in.o(.text+0x73e80): In function `_fh_update':
> > : undefined reference to `export_op_default'
> > fs/built-in.o(.text+0x78150): In function `check_export':
> > : undefined reference to `find_exported_dentry'
> > make[1]: *** [.tmp_vmlinux1] Error 1
> > 
> > thx
> > Peter
> 
> okay, this was a problem in fs/Kconfig
> with the attached patch, it compiled fine for me
> 
> --- linux-2.6.11-fritsch1/fs/Kconfig    2005-02-05 13:17:13.000000000 +0100
> +++ linux-2.6.11-fritsch1/fs/Kconfig    2005-02-05 13:17:54.000000000 +0100
> @@ -1400,6 +1400,7 @@
>          tristate "NFS server support"
>          depends on INET
>          select LOCKD
> +       select EXPORTFS
>          select SUNRPC
>          help
>            If you want your Linux box to act as an NFS *server*, so that 
> other
> 
> thx
> Peter
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

