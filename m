Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263436AbTCNTBo>; Fri, 14 Mar 2003 14:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263443AbTCNTBo>; Fri, 14 Mar 2003 14:01:44 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:28173 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263436AbTCNTBn>; Fri, 14 Mar 2003 14:01:43 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Kernel setup() and initrd problems
Date: 14 Mar 2003 11:12:06 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b4t9i6$eon$1@cesium.transmeta.com>
References: <Pine.GHP.4.53.0303130942100.16619@alderaan.science-computing.de> <Pine.LNX.4.44.0303131051160.7342-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0303131051160.7342-100000@chaos.physics.uiowa.edu>
By author:    Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
In newsgroup: linux.dev.kernel
> 
> I think whoever came up with that just got the idea of pivot_root wrong. 
> The idea was to get rid of the initrd special case. It should be possible 
> to do the following, though I didn't work out the details: 
> 
> Tell the kernel that our root dev is /dev/ram and give it an initrd which 
> isn't really a classical initrd (with /linuxrc on it), but instead has a 
> /sbin/init which is similar to the linuxrc above.
> 

It *is* possible, but you need to pass "root=/dev/ram0" to the kernel,
for backwards compatibility reasons.  That will incidentally make it
run /sbin/init, not /linuxrc, unless you pass init=/linuxrc as well.

See SuperRescue for an example of working use of pivot_root.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
