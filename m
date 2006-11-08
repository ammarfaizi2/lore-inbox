Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965905AbWKHO6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965905AbWKHO6R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 09:58:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965906AbWKHO6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 09:58:16 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:18183 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S965905AbWKHO6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 09:58:15 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: "Hesse, Christian" <mail@earthworm.de>
Subject: Re: 2.6.19-rc5-mm1
Date: Wed, 8 Nov 2006 15:57:20 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20061108015452.a2bb40d2.akpm@osdl.org> <200611081332.36644.mail@earthworm.de> <200611081354.23671.m.kozlowski@tuxland.pl>
In-Reply-To: <200611081354.23671.m.kozlowski@tuxland.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611081557.21516.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > 	This was seen on athlon machine with 'make allmodconfig'.
> > 
> > You need binutils >= 2.16.91.0.2 if CONFIG_KVM is enabled. See "[PATCH 0/14] 
> > KVM: Kernel-based Virtual Machine (v4)" for details and discussion.
> 
> True. Thanks.

binutils upgrade helped. Another problem (also in 2.6.19-rc4-mm2) is:

  CC [M]  drivers/media/video/pwc/pwc-uncompress.o
In file included from drivers/media/video/pwc/pwc-uncompress.c:29:
include/asm/current.h: In function `get_current':
include/asm/current.h:11: error: `size_t' undeclared (first use in this function)
include/asm/current.h:11: error: (Each undeclared identifier is reported only once
include/asm/current.h:11: error: for each function it appears in.)
make[4]: *** [drivers/media/video/pwc/pwc-uncompress.o] Error 1
make[3]: *** [drivers/media/video/pwc] Error 2
make[2]: *** [drivers/media/video] Error 2
make[1]: *** [drivers/media] Error 2
make: *** [drivers] Error 2

It is the same athlon box with 'make allmodconfig'.

Linux localhost 2.6.16-gentoo-r13 #4 PREEMPT Sat Oct 14 17:47:21 CEST 2006 i686 AMD Athlon(tm) XP 1700+ AuthenticAMD GNU/Linux
 
Gnu C                  3.4.6
Gnu make               3.81
binutils               2.17
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
nfs-utils              1.0.6
Linux C Library        > libc.2.4
Dynamic linker (ldd)   2.4
Procps                 3.2.6
Net-tools              1.60
Kbd                    1.12
Sh-utils               6.4
udev                   087
Modules Loaded 

-- 
Regards,

	Mariusz Kozlowski
