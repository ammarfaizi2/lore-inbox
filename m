Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262703AbTCTXne>; Thu, 20 Mar 2003 18:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262659AbTCTXmk>; Thu, 20 Mar 2003 18:42:40 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26640 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262284AbTCTXle>; Thu, 20 Mar 2003 18:41:34 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: major/minor split
Date: 20 Mar 2003 15:52:18 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b5dk7i$md2$1@cesium.transmeta.com>
References: <UTC200303202224.h2KMOXC01107.aeb@smtp.cwi.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <UTC200303202224.h2KMOXC01107.aeb@smtp.cwi.nl>
By author:    Andries.Brouwer@cwi.nl
In newsgroup: linux.dev.kernel
> 
> For kdev_t (8,1) is 0x00080001 and (8,256) is 0x00080100.
> So kdev_t allows simple fast composition and decomposition,
> but is restricted to the kernel.
> While dev_t requires a conditional, since it has to remain
> compatible with the old 8+8 userspace.
> 

I would suggest, instead:

typedef struct kdev {
       u32 major, minor;
} kdev_t;

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
