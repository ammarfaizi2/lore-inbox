Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281204AbRKTSnz>; Tue, 20 Nov 2001 13:43:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281197AbRKTSno>; Tue, 20 Nov 2001 13:43:44 -0500
Received: from schroeder.cs.wisc.edu ([128.105.6.11]:60434 "EHLO
	schroeder.cs.wisc.edu") by vger.kernel.org with ESMTP
	id <S281204AbRKTSn3>; Tue, 20 Nov 2001 13:43:29 -0500
Message-Id: <200111201815.fAKIFat31613@schroeder.cs.wisc.edu>
Content-Type: text/plain; charset=US-ASCII
From: Nick LeRoy <nleroy@cs.wisc.edu>
Organization: UW Condor
To: root@chaos.analogic.com, Christopher Friesen <cfriesen@nortelnetworks.com>
Subject: Re: Swap
Date: Tue, 20 Nov 2001 12:14:38 -0600
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1011120123312.8047A-100000@chaos.analogic.com>
In-Reply-To: <Pine.LNX.3.95.1011120123312.8047A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
> I note that NFS files don't currently return ETXTBSY, but this is a bug.
> It is 'known' to the OS that the NFS mounted file-system is busy because
> you can't unmount the file-system while an executable is running. If
> you can trash it (as you can on Linux), it is surely a bug.
>
> Alan explained a few years ago that NFS was "stateless". Nevertheless
> it is still a bug.

Correct me if I'm wrong, but I think that it's more a bug in the NFS protocol 
than in the Linux (or Solaris, etc) NFS implementation.  The problem is that 
NFS itself just doesn't pass that information along.  The NFS server has no 
idea that the 'text' file is being executed, so it doesn't know that it 
should "return" ETXTBSY.

Now, this might be different in NFS v3, but I'm pretty sure that this applies 
for v2, at least.

-Nick
