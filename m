Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbTEGIL7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 04:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbTEGIL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 04:11:59 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38214 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S262953AbTEGIL6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 04:11:58 -0400
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Using GPL'd Linux drivers with non-GPL, binary-only kernel
References: <20030506164252.GA5125@mail.jlokier.co.uk>
	<m13cjranqb.fsf@frodo.biederman.org>
	<20030506215552.GA6284@mail.jlokier.co.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 May 2003 02:21:25 -0600
In-Reply-To: <20030506215552.GA6284@mail.jlokier.co.uk>
Message-ID: <m1vfwn88vu.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> writes:

> Eric W. Biederman wrote:
> > >  We could even modularise parts of the kernel which aren't
> > > modular now, so that we could take advantage of even more parts of Linux.
> > > 
> > > What do you think?
> > 
> > At the very best support wise you would fall under the same category
> > as if you loaded a binary only driver.
> > 
> > On a very practical side you would suffer severe bitrot.  As I have
> > seen no project that has attempted this being able to keep up with 
> > the kernel API.  Netkit, Mach and MILO are good examples of why not to
> > do this.
> 
> I do not see any practical alternative way to create a new kind of
> operating system kernel that is compatible with the wide range of PC
> hardware, other than:
> 
>   (a) read lots of open source code and then write drivers,
>       filesystems etc. from what is learned, or
>   (b) just use the available code with appropriate wrapping.
> 
> Both are lots of work.  But isn't (b) going to be less work?  I'm not
> sure.

(c) Modify the drivers to fit into your kernel. (See below).
    As far as I know this is the only long term stable approach.
 
> Your mention of Mach leads me to imagine someone saying "don't waste
> your energies writing a new kernel, spend them improving Linux!".  But
> then I think, how is it conceivable to "improve" Linux into a very
> different vision of what an OS kernel can be like?  No, it is
> necessary to experiment with radical new things to try the ideas out,
> yet it is quite impractical to develop drivers from scratch without
> at least _reading_ existing open source code.  And then, maybe it is
> easier to build wrappers than to learn and rewrite.
>
> This whole question comes from that, and the question of whether any
> radical experiment in kernel design would have to be GPL'd to take
> advantage of the Linux driver code, or whether said code would have to
> be rewritten.  (The advantage of the latter is that ideas from many
> operating systems could be more effectively integrated, though, such
> as combining hard drive blacklists from BSD and Linux, etc.)

There is no stable Linux kernel API for drivers.  There is a software
interface but it is continually morphing, changing becoming different
and hopefully better.

The only practical solution I know of (short of porting Linux to run
on top of your kernel), is to use the Linux code as a base as a starting
point and derive your own drivers.  Everyone who attempts to just
reuse the Linux drivers gets stuck with a snapshot of the kernel
at the time they did the work.  Later kernels always wind up unsupported.

The successful example I know of is etherboot.  Where many of it's drivers
are derived from Linux but it is an entirely different source base.   So
etherboot and Linux evolve at different rates.  

Beyond that the whole closed thing is a turn-off.  Which is likely to
reduce interest in your research OS and get you no free feedback on
the weird situations.

Eric
