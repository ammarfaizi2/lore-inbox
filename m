Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbTKKXDq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 18:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbTKKXDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 18:03:46 -0500
Received: from pizda.ninka.net ([216.101.162.242]:16875 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261188AbTKKXDo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 18:03:44 -0500
Date: Tue, 11 Nov 2003 14:57:34 -0800
From: "David S. Miller" <davem@redhat.com>
To: "Kaj-Michael Lang" <milang@tal.org>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, greg@kroah.com
Subject: Re: Linux 2.4.23-rc1
Message-Id: <20031111145734.46d19c87.davem@redhat.com>
In-Reply-To: <002701c3a8a1$b1ce6380$54dc10c3@amos>
References: <Pine.LNX.4.44.0311101723110.2001-100000@logos.cnet>
	<009001c3a89a$af611130$54dc10c3@amos>
	<002701c3a8a1$b1ce6380$54dc10c3@amos>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Nov 2003 00:18:10 +0200
"Kaj-Michael Lang" <milang@tal.org> wrote:

> And on sparc64 I get:
> ...
> sparc64-linux-gcc -D__KERNEL__ -I/work/collection/talinux/kernel/kernel24/tm
> p/sparc64/linux-2.4.22/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 
> -fno-strict-aliasing -fno-common -fomit-frame-pointer -m64 -pipe -mno-fpu -m
> cpu=ultrasparc -mcmodel=medlow -ffixed-g4 -fcall-used-g5 -fcall-used-g7 -Wno
> -sign-compare -Wa,--undeclared-regs -DMODULE  -nostdinc -iwithprefix
> include -DKBUILD_BASENAME=ir_usb  -c -o ir-usb.o ir-usb.c
> ir-usb.c: In function `ir_set_termios':
> ir-usb.c:571: `B4000000' undeclared (first use in this function)
> ir-usb.c:571: (Each undeclared identifier is reported only once
> ir-usb.c:571: for each function it appears in.)

ir-usb.c should not assume all baud speed rate macros are
available on all platforms.
