Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267221AbSLRAL7>; Tue, 17 Dec 2002 19:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267223AbSLRAL6>; Tue, 17 Dec 2002 19:11:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46605 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267221AbSLRAL6>; Tue, 17 Dec 2002 19:11:58 -0500
Date: Tue, 17 Dec 2002 16:20:36 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ulrich Drepper <drepper@redhat.com>
cc: "H. Peter Anvin" <hpa@transmeta.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <3DFF83C5.6000007@redhat.com>
Message-ID: <Pine.LNX.4.44.0212171619230.1578-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Dec 2002, Ulrich Drepper wrote:
>
> This is why I'd say mkae no distinction at all.  Have the first
> nr_syscalls * 8 bytes starting at 0xfffff000 as a jump table.

No, the way sysenter works, the table approach just sucks up dcache space
(the kernel cannot know which sysenter is the one that the user uses
anyway, so the jump table would have to just add back some index and we'd
be back exactly where we started)

I'll keep it the way it is now.

		Linus

