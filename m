Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281124AbRKYVuA>; Sun, 25 Nov 2001 16:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281128AbRKYVtu>; Sun, 25 Nov 2001 16:49:50 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33037 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281105AbRKYVtp>; Sun, 25 Nov 2001 16:49:45 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 2.4.15-final drivers/net/bonding.c includes user space headers
Date: 25 Nov 2001 13:49:33 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9trp1d$ppg$1@cesium.transmeta.com>
In-Reply-To: <18133.1006497103@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <18133.1006497103@kao2.melbourne.sgi.com>
By author:    Keith Owens <kaos@ocs.com.au>
In newsgroup: linux.dev.kernel
>
> 2.4.15-final/drivers/net/bonding.c:188: #include <limits.h>
> 
> Kernel code must not include use space headers.  I thought this had
> been fixed.  It will not compile in 2.5.
> 

<limits.h> is one of the compiler-provided headers, i.e. from
/usr/lib/gcc-lib/*/*/include -- if your kbuild harness don't
allow those headers to be included, it's broken.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
