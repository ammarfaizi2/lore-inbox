Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbTDRIay (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 04:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbTDRIay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 04:30:54 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39687 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262941AbTDRIax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 04:30:53 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Kernel<->Userspace API issue
Date: 18 Apr 2003 01:42:29 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b7odpl$g2l$1@cesium.transmeta.com>
References: <20030418092755.A25177@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20030418092755.A25177@flint.arm.linux.org.uk>
By author:    Russell King <rmk@arm.linux.org.uk>
In newsgroup: linux.dev.kernel
>
> A problem has recently been reported on the ARM lists regarding RT signal
> handling.  It appears that there is an issue between glibc and the kernel,
> in that glibc has a different idea of the layout of structures passed
> from the kernel than the kernel itself.
> 
> I think this is a case in point that our policy on "userspace must not
> include kernel headers" is completely wrong when it comes to user
> space interfaces.  I believe we need is a clear set of defined user
> space interface headers which contain the definition of structures and
> numbers shared between user space and kernel space.  ie, include/abi
> or some such.
> 
> No, glibckernheaders (or whatever it is) is NOT the solution - that
> just creates yet another set of header files to potentially go out
> of sync.
> 

This is basically the "ABI headers" issue I have been harping on about
for some time.  It's a sizable job, though, and a matter of finding
someone to do it.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
