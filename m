Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263401AbTJUVBb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 17:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263408AbTJUVBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 17:01:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:62474 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263401AbTJUVBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 17:01:20 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC] frandom - fast random generator module
Date: 21 Oct 2003 14:00:57 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <bn46q9$1rv$1@cesium.transmeta.com>
References: <3F8E552B.3010507@users.sf.net> <3F8E58A9.20005@cyberone.com.au> <bn40oa$i4q$1@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <bn40oa$i4q$1@gatekeeper.tmr.com>
By author:    davidsen@tmr.com (bill davidsen)
In newsgroup: linux.dev.kernel
>
> In article <3F8E58A9.20005@cyberone.com.au>,
> Nick Piggin  <piggin@cyberone.com.au> wrote:
> 
> | Without looking at the code, why should this be done in the kernel?
> 
> Because it's a generally useful function, /dev/random and /dev/urandom
> are in the kernel, /dev/urandom is SLOW. And doing a userspace solution
> is a bitch in shell scripts ;-)
> 

Bullshit.  "myrng 36 | foo" works just fine.

> Since bloat is being discussed in several threads, you may want to
> propose that /dev/*random be config options in the "delete features for
> size" section.

/dev/random and /dev/urandom are in the kernel because they are
clients of the kernel's entropy collection system, period.  There is
no other justification for their inclusion in the kernel, and using
them as motivation for sticking a pure PRNG in the kernel is daft at
best.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
