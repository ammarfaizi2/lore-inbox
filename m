Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263759AbTFGVav (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 17:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbTFGVau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 17:30:50 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7431 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263759AbTFGVat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 17:30:49 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Maximum swap space?
Date: 7 Jun 2003 14:43:54 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bbtmaq$r03$1@cesium.transmeta.com>
References: <ltptlqb72n.fsf@colina.demon.co.uk> <33435.4.64.196.31.1055008200.squirrel@www.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <33435.4.64.196.31.1055008200.squirrel@www.osdl.org>
By author:    "Randy.Dunlap" <rddunlap@osdl.org>
In newsgroup: linux.dev.kernel
> 
> From http://www.xenotime.net/linux/doc/swap-mini-howto.txt:
> 
> 3.  Swap space limits
> 
> Linux 2.4.10 and later, and Linux 2.5 support any combination of swap
> files or swap devices to a maximum number of 32 of them.  Prior to Linux
> 2.4.10, the limit was any combination of 8 swap files or swap devices.  On
> x86 architecture systems, each of these swap areas has a limit of 2 GiB.
> 

2 GiB is getting a bit tight, especially with tmpfs, ust like the
previous limits of 16 MiB and 128 MiB were getting tight at various
points, and it's annoying to have to make multiple partitions.

tmpfs is a good thing -- in my experience even if it is stored
primarily on disk it is much faster for temp files than any other
filesystem, simply because it never has to worry about consistency.
This means it's entirely reasonable to have a "farm" machine with a
40 GiB tmpfs used for everything except the OS itself.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
