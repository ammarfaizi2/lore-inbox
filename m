Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964880AbVLIVif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964880AbVLIVif (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 16:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964882AbVLIVie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 16:38:34 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:59832 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964880AbVLIVie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 16:38:34 -0500
Subject: Re: i386 -> x86_64 cross compile failure (binutils bug?)
From: Lee Revell <rlrevell@joe-job.com>
To: Ken Moffat <zarniwhoop@ntlworld.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0512092121080.23848@deepthought.mydomain>
References: <1134154208.14363.8.camel@mindpipe>
	 <Pine.LNX.4.63.0512091930440.19998@deepthought.mydomain>
	 <1134158342.18432.1.camel@mindpipe>
	 <Pine.LNX.4.63.0512092121080.23848@deepthought.mydomain>
Content-Type: text/plain
Date: Fri, 09 Dec 2005 16:40:02 -0500
Message-Id: <1134164403.18432.33.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 21:30 +0000, Ken Moffat wrote:
> On Fri, 9 Dec 2005, Lee Revell wrote:
> 
> >
> > $ file init/built-in.o
> > init/built-in.o: ELF 64-bit LSB relocatable, AMD x86-64, version 1
> > (SYSV), not stripped
> >
> >> From man gcc, i386 section:
> >
> > -m32
> > -m64
> >    Generate code for a 32-bit or 64-bit environment.  The 32-bit
> >    environment sets int, long and pointer to 32
> >    bits and generates code that runs on any i386 system.  The
> >    64-bit environment sets int to 32 bits and long
> >    and pointer to 64 bits and generates code for AMD's x86-64
> >    architecture.
> >
> > Lee
> >
> 
>   Yes, file shows your gcc does indeed do the right thing with -m64, and 
> thank you, but I was already familiar with -m64 (to say nothing of 
> passing LDEMULATION to userspace compilations [info binutils, if you 
> need to know]).
> 
>   So, do you have some sort of religious objection to using 
> CROSS_COMPILE= when building for a processor that doesn't match the 
> userspace ?  And I repeat, messing with CFLAGS should NOT be necessary.

It seems like CROSS_COMPILE= should not be needed if my standard gcc
binary can produce x86-64 code.  I was hoping it would be possible to
build an x86-64 kernel using the Ubuntu packages and that I would not
have to resort to building my own toolchain.  And it seems that it's
supposed to work, but doesn't.

Lee

