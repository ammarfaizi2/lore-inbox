Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268339AbTCFUQI>; Thu, 6 Mar 2003 15:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268332AbTCFUP6>; Thu, 6 Mar 2003 15:15:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:45062 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268339AbTCFUPt>; Thu, 6 Mar 2003 15:15:49 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patch] work around gcc-3.x inlining bugs
Date: 6 Mar 2003 12:26:11 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b48at3$5pt$1@cesium.transmeta.com>
References: <20030306032208.03f1b5e2.akpm@digeo.com.suse.lists.linux.kernel> <p73fzq067an.fsf@amdsimf.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <p73fzq067an.fsf@amdsimf.suse.de>
By author:    Andi Kleen <ak@suse.de>
In newsgroup: linux.dev.kernel
> 
> I submitted a similar patch (using -include) it to Linus some time ago.
> It's even required to work around gcc 3.3 inlining bugs.
> Unfortunately he didn't like it and prefered __force_inline
> to be added to the places that really rely on inline.
> 

I would like to suggest that always_inline is defined as
"extern __inline__" plus whatever the particular compiler needs, and
that plain inline is redefined as "static __inline__" or whatever.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
