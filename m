Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129466AbRCADD6>; Wed, 28 Feb 2001 22:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129468AbRCADDt>; Wed, 28 Feb 2001 22:03:49 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:26531 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129466AbRCADDh>; Wed, 28 Feb 2001 22:03:37 -0500
Message-ID: <3A9DBAF2.87E7D005@coplanar.net>
Date: Wed, 28 Feb 2001 21:58:58 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "Collins, Tom" <Tom.Collins@Surgient.com>, linux-kernel@vger.kernel.org
Subject: Re: Dynamically altering code segments
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


"Collins, Tom" wrote:

> Hi...
>
> This is my first post, so if this is off topic for this list, please
direct
> me
> to another one that is more appropriate.  Thanks
>
> That said, I am wanting to dynamically modify the kernel in specific
places
> to
> implement a custom kernel trace mechanism.  The general idea is that,
when
> the
> "trace" is off, there are NOP instruction sequences at various places
in the
> kernel.  When the "trace" is turned on, those same NOPs are replaced
by JMPs
> to code that implements the trace (such as logging events, using the
MSR and
> PMC's etc..).
>
> This was a trick that was done in my old days of OS/2 performance
tools
> developement to get trace information from the running kernel.  In
that
> case,
> we simply remapped the appropriate code segments to data segments (I
think
> back then it was called 'aliasing code segments') and used that
segment to
> make changes to the kernel code on the fly.
>
> Is it possible to do the same thing in Linux?
>

the CS and DS segment descriptors already both map 0-4G, the DS being
read-write.
what you want is to change page protections, the system call mprotect()
comes
to mind.



