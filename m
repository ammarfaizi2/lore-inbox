Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbTKTRdf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 12:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263057AbTKTRdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 12:33:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34054 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263024AbTKTRdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 12:33:33 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: transmeta cpu code question
Date: 20 Nov 2003 09:33:18 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bpitsu$732$1@cesium.transmeta.com>
References: <20031120020218.GJ3748@schottelius.org> <200311201210.04780.ben@jeeves.bpa.nu> <20031120083827.GL3748@schottelius.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20031120083827.GL3748@schottelius.org>
By author:    Nico Schottelius <nico-mutt@schottelius.org>
In newsgroup: linux.dev.kernel
> 
> I am still interested whether there are possibilities to
>    a) use the crusoe without the morphing software (to use its native
>       command set)

No.  You really don't want to -- the native instruction set doesn't
look like anything Linux likes to see, and worse, there are binary
incompatibilities not just from processor to processor but sometimes
from silicon revision to silicon revision.

It's also not faster in any meaningful way, since the dynamic
translator does optimistic optimization.

>    b) to fine tune Linux to my specific processor, to make it use all
>       available feautures the processor has.

The biggest problem we've found is that a lot of distributions will
install an i586 libc even though we have (and export) all the
necessary features.  Crusoe reports family = 5 mainly to work around a
bug in Some Other Operating System[TM], but supports all
userspace-visible i686 features gcc expects.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
