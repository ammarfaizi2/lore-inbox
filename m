Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262997AbTCLA3W>; Tue, 11 Mar 2003 19:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262994AbTCLA3V>; Tue, 11 Mar 2003 19:29:21 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:48134 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262997AbTCLA25>; Tue, 11 Mar 2003 19:28:57 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
Date: 11 Mar 2003 16:39:30 -0800
Organization: Transmeta Corporation
Message-ID: <b4lvk2$vcd$1@cesium.transmeta.com>
References: <32835.4.64.238.61.1047269795.squirrel@www.osdl.org> <Pine.LNX.4.30.0303100723300.2790-100000@divine.city.tvnet.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.30.0303100723300.2790-100000@divine.city.tvnet.hu>,
Szakacsits Szabolcs  <szaka@sienet.hu> wrote:
>
>At least spinlock debugging triggers this bad code generation in the
>widely used init_waitqueue_head() but quite probably there are others.
>AFAIK fomit-frame-pointer was used earlier to workaround this but
>apparently not anymore, so the bug came back. Maybe the new kernel
>build broke it or it was just forgotten or it's a new policy not
>supporting broken compilers, etc. I don't know.
>
>But something should be done about it, IMHO.

Ouch, hell yes. Compiler bugs are nasty to chase down.

If there is a well-known list of compilers, we should put a BIG warning
in some core kernel file to guide people to upgrade (or maybe work
around it by forcing -fno-frame-pointer if that fixes it for the
affected compilers).

Do we have a list?

			Linus
