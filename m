Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbTBYBZC>; Mon, 24 Feb 2003 20:25:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265037AbTBYBZA>; Mon, 24 Feb 2003 20:25:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15120 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265339AbTBYBYX>; Mon, 24 Feb 2003 20:24:23 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Remote execution of syscalls (was  Re: Syscall from Kernel Space)
Date: 24 Feb 2003 17:34:21 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b3eh6t$ebi$1@cesium.transmeta.com>
References: <20030221174414.GA28062@ime.usp.br> <Pine.LNX.4.44.0302212321530.6139-100000@students.iiit.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.44.0302212321530.6139-100000@students.iiit.net>
By author:    Prasad <prasad_s@students.iiit.net>
In newsgroup: linux.dev.kernel
>
> 
> before anything else, thanx for the response, i was very much discouraged 
> by the fact that i did not get any replies...
> 
> coming to whats happening...  lets see it this way... Theres a process (x)  
> that is migrated to some other node. Now any syscall that the process (X)  
> makes is to be shipped back to the originating node.  Say i have a user
> thread (Y) running and receiving requests for syscall executions.  And now
> if i execute a syscall, the syscall will be executed as of (Y) is 
> executing it, but i want the syscall to run as if (X) is executing it!
> The process (X) still exists on the originating system, but is idle.
> 

Sounds like you should let the otherwise-idle process X be the thread
that waits for the connection and issues system calls.  This is
basically RPC.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: cris ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
