Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263379AbTDVTDB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 15:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263381AbTDVTDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 15:03:01 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3847 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263379AbTDVTDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 15:03:00 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Remove __const__ due to GCC warning
Date: 22 Apr 2003 12:14:49 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b844b9$sbp$1@cesium.transmeta.com>
References: <20030422160953.GF7260@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030422160953.GF7260@debian>
By author:    Art Haas <ahaas@airmail.net>
In newsgroup: linux.dev.kernel
>
> Hi.
> 
> These two patches remove a warning GCC produces about using __const__
> where it doesn't matter. I've built numerous kernels with these patches
> and things seem to work fine, so I thought I'd send them out. Maybe GCC
> is right, or maybe it isn't ...
> 
> BTW, the warning appears if '-W' is added to the compile commands.
> 

This seems like the wrong approach.  Instead this presumably should be
__attribute__((const)) instead.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
