Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263800AbTKKXKe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 18:10:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263808AbTKKXKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 18:10:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52416 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263800AbTKKXKb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 18:10:31 -0500
Date: Tue, 11 Nov 2003 23:10:27 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: "David S. Miller" <davem@redhat.com>
Cc: Kaj-Michael Lang <milang@tal.org>, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org, greg@kroah.com
Subject: Re: Linux 2.4.23-rc1
Message-ID: <20031111231027.GC24159@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.44.0311101723110.2001-100000@logos.cnet> <009001c3a89a$af611130$54dc10c3@amos> <002701c3a8a1$b1ce6380$54dc10c3@amos> <20031111145734.46d19c87.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031111145734.46d19c87.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 11, 2003 at 02:57:34PM -0800, David S. Miller wrote:
> On Wed, 12 Nov 2003 00:18:10 +0200
> "Kaj-Michael Lang" <milang@tal.org> wrote:
> 
> > And on sparc64 I get:
> > ...
> > sparc64-linux-gcc -D__KERNEL__ -I/work/collection/talinux/kernel/kernel24/tm
> > p/sparc64/linux-2.4.22/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 
> > -fno-strict-aliasing -fno-common -fomit-frame-pointer -m64 -pipe -mno-fpu -m
> > cpu=ultrasparc -mcmodel=medlow -ffixed-g4 -fcall-used-g5 -fcall-used-g7 -Wno
> > -sign-compare -Wa,--undeclared-regs -DMODULE  -nostdinc -iwithprefix
> > include -DKBUILD_BASENAME=ir_usb  -c -o ir-usb.o ir-usb.c
> > ir-usb.c: In function `ir_set_termios':
> > ir-usb.c:571: `B4000000' undeclared (first use in this function)
> > ir-usb.c:571: (Each undeclared identifier is reported only once
> > ir-usb.c:571: for each function it appears in.)
> 
> ir-usb.c should not assume all baud speed rate macros are
> available on all platforms.

Umm...   Why are they defined in asm-*/* and not in linux/*?
