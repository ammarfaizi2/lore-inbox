Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbTELAz0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 20:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbTELAz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 20:55:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16914 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261785AbTELAzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 20:55:21 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Use correct x86 reboot vector
Date: 11 May 2003 18:07:54 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b9ms5a$gcg$1@cesium.transmeta.com>
References: <m1fznl74f9.fsf@frodo.biederman.org> <Pine.LNX.4.44.0305111124240.12955-100000@home.transmeta.com> <20030511190023.GC9173@waste.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030511190023.GC9173@waste.org>
By author:    Matt Mackall <mpm@selenic.com>
In newsgroup: linux.dev.kernel
> 
> There's a missing piece of behavior here that's probably fatal.
> Namely, the next time the CS descriptor is loaded, even with the same
> value, the high bits are lost. So, for example, if you're running BIOS
> out of ROM, decompressing it into the top of 20-bit address space,
> then long jumping to your uncompressed code, you don't want to find
> yourself back in ROM.
> 

Nope, that's *exactly* the desired behaviour.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
