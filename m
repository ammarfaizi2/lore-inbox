Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265950AbTL3US3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 15:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265948AbTL3US2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 15:18:28 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46863 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S265923AbTL3USJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 15:18:09 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] optimize ia32 memmove
Date: 30 Dec 2003 12:17:59 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bssmhn$bt$1@cesium.transmeta.com>
References: <200312300713.hBU7DGC4024213@hera.kernel.org> <Pine.LNX.4.58.0312300152250.2065@home.osdl.org> <1072779479.16344.95.camel@ixodes.goop.org> <3FF15DAB.8080203@colorfullife.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3FF15DAB.8080203@colorfullife.com>
By author:    Manfred Spraul <manfred@colorfullife.com>
In newsgroup: linux.dev.kernel
> 
> AMD recommends to perform bulk copies backwards: That defeats the hw 
> prefecher, and results in even better access patterns. Doesn't matter in 
> this case, memmove is never used for bulk copies.
> 

That's also a microoptimization for one particular microarchitecture
*bug*.  Hardware prefetchers are going omnidirectional going forward.
Additionally, nearly all bulk copies are performed forward (DF=0) in
existing codebases.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
