Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbTDNSWv (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 14:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbTDNSPF (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 14:15:05 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58893 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263633AbTDNSDV (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 14:03:21 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: sysenter on x86
Date: 14 Apr 2003 11:14:57 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b7etr1$s27$1@cesium.transmeta.com>
References: <20030412135457.GB19869@codeblau.de> <1050156926.1449.2.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1050156926.1449.2.camel@laptop.fenrus.com>
By author:    Arjan van de Ven <arjanv@redhat.com>
In newsgroup: linux.dev.kernel
>
> 
> --=-EFK+Hzuvs0Z6BUNjBVGk
> Content-Type: text/plain
> Content-Transfer-Encoding: quoted-printable
> 
> On Sat, 2003-04-12 at 15:54, Felix von Leitner wrote:
> > I just added sysenter support for linux-2.5 on x86 to the diet libc, but
> > I noted that the original patch said user space should jump to
> > 0xfffff000, which segfaults.  Jumping to 0xffffe000 works.
> >=20
> > I suggest adding a comment somewhere in the kernel about the proper
> > calling convention, because the glibc code is frankly not readable in
> > this regard.
> 
> you HAVE to use the location as specified with the AT_SYSINFO elf flag.
> The kernel is free to move this address around between builds, as long
> as AT_SYSINFO gives the address for the location.
> 

... which quite frankly kind of bites :(

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
