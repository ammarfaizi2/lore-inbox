Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263828AbTKFUl2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 15:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263830AbTKFUl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 15:41:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6663 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263828AbTKFUl1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 15:41:27 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__
	defined (trivial)
Date: 6 Nov 2003 12:40:55 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <boebkn$pmv$1@cesium.transmeta.com>
References: <1068140199.12287.246.camel@nosferatu.lan> <1068149368.12287.331.camel@nosferatu.lan> <20031106120548.097ccc7c.davem@redhat.com> <1068150552.12287.349.camel@nosferatu.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1068150552.12287.349.camel@nosferatu.lan>
By author:    Martin Schlemmer <azarah@gentoo.org>
In newsgroup: linux.dev.kernel
> 
> If you look at asm/types.h, u64 is kernel only namespace, so in
> theory that code will not be in userspace.  Also, the whole idea
> of this patch (the first one that touched byteorder.h, and not the
> second that touched types.h), was to encase everything that used
> __u64 that _is_ in userspace in __STRICT_ANSI__.  If there thus
> was another place that did use __u64 outside a ifdef __STRICT_ANSI__,
> the compile would anyhow stop with -ansi.
> 

Note that "long long" (the underlying type) is valid
standards-compliant C99.  gcc can handle it when in C89 mode if
defined as __extension__ long long IIRC.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
