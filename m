Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263887AbTKFXk6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 18:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263888AbTKFXk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 18:40:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62479 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263887AbTKFXkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 18:40:55 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__
 defined (trivial)
Date: 6 Nov 2003 15:40:48 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <boem60$hve$1@cesium.transmeta.com>
References: <1068140199.12287.246.camel@nosferatu.lan> <1068150552.12287.349.camel@nosferatu.lan> <boebkn$pmv$1@cesium.transmeta.com> <20031106143110.6231ecde.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20031106143110.6231ecde.davem@redhat.com>
By author:    "David S. Miller" <davem@redhat.com>
In newsgroup: linux.dev.kernel
>
> On 6 Nov 2003 12:40:55 -0800
> "H. Peter Anvin" <hpa@zytor.com> wrote:
> 
> > Note that "long long" (the underlying type) is valid
> > standards-compliant C99.  gcc can handle it when in C89 mode if
> > defined as __extension__ long long IIRC.
> 
> That's correct and I've suggested this.
> 
> But keep in mind that people with non-GCC compilers will then
> start complaining.
>

So...

#ifdef __GNUC__
# define __gcc_extension __extension__
#else
# define __gcc_extension
#endif

typedef __gcc_extension signed long long s32;
typedef __gcc_extension unsigned long long u32;

	-hpa


-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
