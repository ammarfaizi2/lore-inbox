Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267500AbTBYDp5>; Mon, 24 Feb 2003 22:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267558AbTBYDp4>; Mon, 24 Feb 2003 22:45:56 -0500
Received: from [196.12.44.6] ([196.12.44.6]:28318 "EHLO students.iiit.net")
	by vger.kernel.org with ESMTP id <S267500AbTBYDpz>;
	Mon, 24 Feb 2003 22:45:55 -0500
Date: Tue, 25 Feb 2003 09:27:30 +0530 (IST)
From: Prasad <prasad_s@students.iiit.net>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Remote execution of syscalls (was  Re: Syscall from Kernel Space)
In-Reply-To: <b3eh6t$ebi$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302250924340.4506-100000@students.iiit.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 24 Feb 2003, H. Peter Anvin wrote:
> > 
> > coming to whats happening...  lets see it this way... Theres a process (x)  
> > that is migrated to some other node. Now any syscall that the process (X)  
> > makes is to be shipped back to the originating node.  Say i have a user
> > thread (Y) running and receiving requests for syscall executions.  And now
> > if i execute a syscall, the syscall will be executed as of (Y) is 
> > executing it, but i want the syscall to run as if (X) is executing it!
> > The process (X) still exists on the originating system, but is idle.
> > 
> 
> Sounds like you should let the otherwise-idle process X be the thread
> that waits for the connection and issues system calls.  This is
> basically RPC.
> 

but again... in this case i got to replace the loaded executable by one
that accepts the connections while maintaining the mmap, the open files.  
Can someone suggest me how this could be done... I am totally unaware of
stuff like this.

Prasad.

-- 
Failure is not an option

