Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTEFVnV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 17:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbTEFVnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 17:43:21 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:9088 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S261970AbTEFVnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 17:43:20 -0400
Date: Tue, 6 May 2003 22:55:52 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Using GPL'd Linux drivers with non-GPL, binary-only kernel
Message-ID: <20030506215552.GA6284@mail.jlokier.co.uk>
References: <20030506164252.GA5125@mail.jlokier.co.uk> <m13cjranqb.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m13cjranqb.fsf@frodo.biederman.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> > So, as dynamic loading is ok between parts of Linux and binary-only
> > code, that seems to imply we could build a totally different kind of
> > binary-only kernel which was able to make use of all the Linux kernel
> > modules.
> 
> If you build a kernel to run Linux drivers that seems to scream
> derivative work to me.

I'd agree if the sole purpose of the kernel were to run those drivers.
But if it were built for other reasons, such as an experiment in a
different kind of operating system, and it happens to have very good
support for the Linux driver API?  I'd say that's not a derivative
work, even though the interface is clearly designed to support Linux
drivers.  But now we _are_ into the lawyer zone.

> >  We could even modularise parts of the kernel which aren't
> > modular now, so that we could take advantage of even more parts of Linux.
> > 
> > What do you think?
> 
> At the very best support wise you would fall under the same category
> as if you loaded a binary only driver.
> 
> On a very practical side you would suffer severe bitrot.  As I have
> seen no project that has attempted this being able to keep up with 
> the kernel API.  Netkit, Mach and MILO are good examples of why not to
> do this.

I do not see any practical alternative way to create a new kind of
operating system kernel that is compatible with the wide range of PC
hardware, other than:

  (a) read lots of open source code and then write drivers,
      filesystems etc. from what is learned, or
  (b) just use the available code with appropriate wrapping.

Both are lots of work.  But isn't (b) going to be less work?  I'm not
sure.

Your mention of Mach leads me to imagine someone saying "don't waste
your energies writing a new kernel, spend them improving Linux!".  But
then I think, how is it conceivable to "improve" Linux into a very
different vision of what an OS kernel can be like?  No, it is
necessary to experiment with radical new things to try the ideas out,
yet it is quite impractical to develop drivers from scratch without
at least _reading_ existing open source code.  And then, maybe it is
easier to build wrappers than to learn and rewrite.

This whole question comes from that, and the question of whether any
radical experiment in kernel design would have to be GPL'd to take
advantage of the Linux driver code, or whether said code would have to
be rewritten.  (The advantage of the latter is that ideas from many
operating systems could be more effectively integrated, though, such
as combining hard drive blacklists from BSD and Linux, etc.)

-- Jamie
