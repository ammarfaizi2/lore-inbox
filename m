Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbUCVTBQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 14:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262257AbUCVTBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 14:01:11 -0500
Received: from waste.org ([209.173.204.2]:33232 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262260AbUCVTA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 14:00:58 -0500
Date: Mon, 22 Mar 2004 13:00:50 -0600
From: Matt Mackall <mpm@selenic.com>
To: Matt Miller <mmiller@hick.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6: mmap complement, fdmap
Message-ID: <20040322190047.GC8366@waste.org>
References: <Pine.LNX.4.58.0403212157110.31106@jethro.hick.org> <20040322053025.GR31500@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0403212346330.24801@jethro.hick.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403212346330.24801@jethro.hick.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2004 at 12:14:56AM -0600, Matt Miller wrote:
> > On Sun, Mar 21, 2004 at 10:43:07PM -0600, Matt Miller wrote:
> > > 	``flags'' can be one of O_RDONLY, O_WRONLY, or O_RDWR.
> > >
> > > I have verified functionality on ia32 and sparc as these are the only
> > > architectures I currently have some type of access to.  To test, start the
> > > kernel configuration process and go under File systems/Pseudo filesystems
> > > and select this option:
> > >
> > > 	[*] Virtual memory file descriptor mapping support
> > >
> > > Please let me know about any and all suggestions/bugs/flames.  I tried to
> >
> > *boggle*
> >
> > a) what the hell for?
> 
> It's targetted mainly as a performance enhancer.  Some of the specific
> scenarios where it would be useful are:
> 
> a) When one cannot afford to take the performance hit of synchronizing
>    a memory range to disk due to disk size limitations or speed
>    requirements.
> b) Some things can benefit from the ability to interface with memory as a
>    file.
> 
> The specific reason for implementing this was to allow for loading dynamic
> libraries in the context of a process without having to write them to
> disk.

How about tmpfs/ramfs instead? Open a file on tmpfs and mmap it and
you've got the same thing without any of the nasty corner cases.
 
-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
