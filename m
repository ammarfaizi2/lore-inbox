Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263251AbTDRVNS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 17:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263253AbTDRVNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 17:13:18 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22803 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263251AbTDRVNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 17:13:17 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: mknod64(1)
Date: 18 Apr 2003 14:24:53 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b7pqf5$kqv$1@cesium.transmeta.com>
References: <1050700383.745.48.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1050700383.745.48.camel@localhost>
By author:    Robert Love <rml@tech9.net>
In newsgroup: linux.dev.kernel
>
> So I wrote a mknod64(1) tool, so we can play with 64-bit device
> numbers.  It is available at:
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/rml/mknod64
> 
> for testing.  And that is really its whole purpose because I see no
> reason why the mknod in coreutils will not eventually support
> mknod64(2).
> 

Well, actually, once glibc is updated to call SYS_mknod64 and have the
right MAJOR() and MINOR() macros, it shouldn't require any changes to
mknod(1).

What would probably be useful for mknod(1), if it doesn't already, is
to allow the major/minor to be specified in any of the standard bases,
i.e. using strtoul(...,...,0).

I belive HP/UX (which have had 32-bit minors for a long time) actually
had ls -l display hexadecimal minors.  I am not advocating that,
however, it probably would break too many scripts.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
