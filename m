Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291338AbSBGVmR>; Thu, 7 Feb 2002 16:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291333AbSBGVmI>; Thu, 7 Feb 2002 16:42:08 -0500
Received: from barbados.bluemug.com ([63.195.182.101]:13578 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S291338AbSBGVlw>; Thu, 7 Feb 2002 16:41:52 -0500
Date: Thu, 7 Feb 2002 13:41:45 -0800
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: How to check the kernel compile options ?
Message-ID: <20020207214145.GA27645@bluemug.com>
Mail-Followup-To: Daniel Phillips <phillips@bonn-fries.net>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <a3mjhc$qba$1@cesium.transmeta.com> <E16Yu52-00015I-00@starship.berlin> <20020207203451.GE26826@bluemug.com> <E16Yvmf-00015n-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16Yvmf-00015n-00@starship.berlin>
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 10:08:44PM +0100, Daniel Phillips wrote:
> On February 7, 2002 09:34 pm, Mike Touloumtzis wrote:
> > A final argument for using packaging/bundling tools and userspace files
> > instead of files in /proc for tracking kernel metadata:
> > 
> > -- Kernels are no longer single files, at least for most people.
> >    A _harder_ problem than this one is tracking which modules go with
> >    which kernel.  Solving this problem solves the configuration tracking
> >    problem as a _side_effect_.  Conversely, solving the configuration
> >    tracking problem without solving the module tracking problem is
> >    largely useless.
> 
> I can always rebuild the modules from a standard source tree, given the 
> config.  This makes the config a far more important piece of data than the 
> modules themselves, and that is why I want it stuck right on the side of the 
> kernel, the way my memory sticks have a little sticker on them telling me 
> what I've got.
> 
> As an option of course, you're welcome to build your kernel without it, and 
> you can also peel the stickers off your memory sticks and file them in a 
> drawer if you like.

OK, this is getting a little silly, and I don't have many new arguments
to make, so I'll just respond once.  Feel free to have the last word :-).

Peeling information off memory sticks would be silly.  It's already _on_
them memory, and it costs nothing to leave it there.  Moreover, if you're
using a packaging system, putting config info in the package is precisely
analogous to attaching an informative sticker to the kernel.

Adding configuration information to the kernel is a change to the status
quo, and has a cost.  The cost is small, but I'm unsympathetic to that
argument because many small convenience features, each with a small cost,
add up to a large cost.

You appear to be justifying a change to the kernel status quo with the
argument "it is a useful feature for some people, so it should go in".
I agree that it's useful for some people, but I feel that the kernel
should hold to a higher standard for feature inclusion: "It's a useful
feature for some people, and it is impossible or impractical to implement
it well in userspace."  Even esoteric drivers meet my test; IMHO the
inclusion of configuration files in the kernel does not.

My contention is that not only is it _possible_ to implement a solution
in userspace (which alone should be enough), but that a userspace solution
is _already implemented and widely used_, and that moreover I am perfectly
happy using it.  I don't see why that shouldn't be the kiss of death for
adding a new feature to the kernel.

miket
