Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbWB0Ttl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWB0Ttl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 14:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751510AbWB0Ttl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 14:49:41 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:3525 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1751498AbWB0Ttl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 14:49:41 -0500
Date: Mon, 27 Feb 2006 11:49:41 -0800
From: Greg KH <gregkh@suse.de>
To: Diego Calleja <diegocg@gmail.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       akpm@osdl.org, davej@redhat.com, perex@suse.cz, kay.sievers@vrfy.org
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Message-ID: <20060227194941.GD9991@suse.de>
References: <20060227190150.GA9121@kroah.com> <20060227203520.0df1d548.diegocg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060227203520.0df1d548.diegocg@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2006 at 08:35:20PM +0100, Diego Calleja wrote:
> El Mon, 27 Feb 2006 11:01:50 -0800,
> Greg KH <greg@kroah.com> escribi?:
> 
> 
> > I've sketched out a directory structure that starts in
> > Documentation/ABI/ and has five different states, "stable", "testing",
> > "unstable", "obsolete", and "private".  The README file describes these
> 
> With the current development model, does it have sense to have a "testing"
> stage? Once the interfaces are released in the main kernel, people is going
> to use them just like they were stable...

The whole point of this document is to state that they should be wary of
doing so, and be aware that things can change.  And also that they need
to work _with_ the kernel developers if they are relying on things that
are "unstable" or in "testing" to be notified of future changes and just
to help make things move to "stable" quicker and more smoothly.

Also, if you look at other operating systems, they have this same kind
of "levels" of stability for their interfaces, so this is nothing new.
For us to say that our "first cut" implementation of some of these
interfaces should instantly be marked "stable" is just folley if we
think that we know-all about how stuff will work once it's being used by
lots of different people.  I'm sure as hell not that smart to get
everything right the very first time, even if you might be :)

An explicit example of this is the evolution that sys_futex went
through, even after it was made a syscall...

thanks,

greg k-h
