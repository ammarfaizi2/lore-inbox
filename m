Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318994AbSIDA6R>; Tue, 3 Sep 2002 20:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318995AbSIDA6R>; Tue, 3 Sep 2002 20:58:17 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25093 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318994AbSIDA6Q>; Tue, 3 Sep 2002 20:58:16 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: TCP Segmentation Offloading (TSO)
Date: 3 Sep 2002 18:02:17 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <al3m2p$lnp$1@cesium.transmeta.com>
References: <288F9BF66CD9D5118DF400508B68C4460283E564@orsmsx113.jf.intel.com> <200209021858.WAA00388@sex.inr.ac.ru> <20020903.164243.21934772.taka@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020903.164243.21934772.taka@valinux.co.jp>
By author:    Hirokazu Takahashi <taka@valinux.co.jp>
In newsgroup: linux.dev.kernel
> 
> P.S.
>     Using "bswap" is little bit tricky.
> 

It needs to be protected by CONFIG_I486 and alternate code implemented
for i386 (xchg %al,%ah; rol $16,%eax, xchg %al,%ah for example.)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
