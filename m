Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313907AbSDTAKB>; Fri, 19 Apr 2002 20:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314149AbSDTAKA>; Fri, 19 Apr 2002 20:10:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:25860 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313907AbSDTAJ7>; Fri, 19 Apr 2002 20:09:59 -0400
Date: Fri, 19 Apr 2002 17:09:49 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: bgerst@didntduck.org, <andrea@suse.de>, <ak@suse.de>,
        <linux-kernel@vger.kernel.org>, <jh@suse.cz>
Subject: Re: [PATCH] Re: SSE related security hole
In-Reply-To: <1577.131.107.184.92.1019260888.squirrel@www.zytor.com>
Message-ID: <Pine.LNX.4.44.0204191708360.6542-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 19 Apr 2002, H. Peter Anvin wrote:
>
> Indeed.  Logically, FNINIT should have been extended to initialize it all -
> - it is a security hole that it doesn't initialize MMX properly.

Well, MMX should arguably be initialized with "emms", so the proper
sequence migth be something like

	if (sse)
		asm("emms");
	asm("fninit");

What does emms do to SSE2?

		Linus

