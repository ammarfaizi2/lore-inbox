Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311816AbSCNV5B>; Thu, 14 Mar 2002 16:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311818AbSCNV4x>; Thu, 14 Mar 2002 16:56:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4871 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S311816AbSCNV4o>; Thu, 14 Mar 2002 16:56:44 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: IO delay, port 0x80, and BIOS POST codes
Date: 14 Mar 2002 13:56:20 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a6r6a4$8hg$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0203141324480.9855-100000@penguin.transmeta.com> <Pine.LNX.3.95.1020314164142.382B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.3.95.1020314164142.382B-100000@chaos.analogic.com>
By author:    "Richard B. Johnson" <root@chaos.analogic.com>
In newsgroup: linux.dev.kernel
> 
> Well no, IO doesn't "time-out". The PC/AT/ISA bus is asychronous, it's
> not clocked. If there's no hardware activity as a result of the write
> to nowhere, it's just a no-op. The CPU isn't slowed down at all. It's
> just some bits that got flung out on the bus with no feed-back at all.
> 

An OUT on the x86 architecture is synchronous... the CPU will not
proceed until the OUT is present on the bus.  This is a requirement of
the SMM architecture, actually.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
