Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315925AbSFESSF>; Wed, 5 Jun 2002 14:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315929AbSFESSF>; Wed, 5 Jun 2002 14:18:05 -0400
Received: from 01-026.118.popsite.net ([66.19.120.26]:260 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S315925AbSFESSD>;
	Wed, 5 Jun 2002 14:18:03 -0400
Date: Wed, 5 Jun 2002 14:14:39 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>, Andrew Morton <akpm@zip.com.au>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] "laptop mode"
Message-ID: <20020605181439.GA5316@nevyn.them.org>
Mail-Followup-To: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
	Andrew Morton <akpm@zip.com.au>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3CFD453A.B6A43522@zip.com.au> <200206050341.g553fvi09850@saturn.cs.uml.edu> <20020605170735.GA18036@pimlott.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 01:07:35PM -0400, Andrew Pimlott wrote:
> On Tue, Jun 04, 2002 at 11:41:57PM -0400, Albert D. Cahalan wrote:
> > Also write out everything just before stopping the disk.
> > Don't let the disk stop if there is any dirty data.
> 
> The kernel doesn't currently do spin-down at all, does it?  Andrew,
> are you planning to change this?  I'm not a kernel programmer, but
> it seems like a good idea to me:  The kernel could flush writes as
> usual while the disk is spun up, but still spin down after a bit if
> the rate is low enough.  The disk would never spin itself down in
> that case.  Maybe there are also cases where the kernel would delay
> spin-down, if it hasn't started writing but thinks it might soon.
> 
> I'm excited to try this.  Thanks for writing it against 2.4!

At that point, you might as well be in userspace - particularly, you
might as well be running/enhancing noflushd.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
