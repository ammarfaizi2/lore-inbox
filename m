Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262214AbTCHVQQ>; Sat, 8 Mar 2003 16:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbTCHVQQ>; Sat, 8 Mar 2003 16:16:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:5128 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262214AbTCHVQP>; Sat, 8 Mar 2003 16:16:15 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] register_blkdev
Date: 8 Mar 2003 13:26:37 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b4dn6d$go8$1@cesium.transmeta.com>
References: <UTC200303080057.h280v0o28591.aeb@smtp.cwi.nl> <20030308073407.A24272@infradead.org> <20030308192908.GB26374@kroah.com> <20030308194331.A31291@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030308194331.A31291@infradead.org>
By author:    Christoph Hellwig <hch@infradead.org>
In newsgroup: linux.dev.kernel
> 
> So people should have started working on it sooner.  If people really think
> they need a 32bit dev_t for their $BIGNUM of disks (and I still don't buy
> that argument) we should just introduce it and use it only for block devices
> (which already are fixed up for this) and stay with the old 8+8 split for
> character devices.  Note that Linux is about doing stuff right, not fast.
> 

We need it if anything even more for character devices.  Character
devices are under even more allocation pressure, and just look at the
ugly hacks we've already had to play for e.g. tty devices.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
