Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315981AbSE3AsV>; Wed, 29 May 2002 20:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315988AbSE3AsU>; Wed, 29 May 2002 20:48:20 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:5117 "EHLO branoic")
	by vger.kernel.org with ESMTP id <S315981AbSE3AsS>;
	Wed, 29 May 2002 20:48:18 -0400
Date: Wed, 29 May 2002 20:48:12 -0400
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
To: "David S. Miller" <davem@redhat.com>
Cc: ppadala@cise.ufl.edu, linux-kernel@vger.kernel.org
Subject: Re: No PTRACE_READDATA for archs other than SPARC?
Message-ID: <20020530004811.GA5921@branoic.them.org>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	ppadala@cise.ufl.edu, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.05.10205192307500.26915-100000@rain.cise.ufl.edu> <20020519.214053.19164382.davem@redhat.com> <20020529234951.GA3797@branoic.them.org> <20020529.173118.130757558.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2002 at 05:31:18PM -0700, David S. Miller wrote:
>    From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
>    Date: Wed, 29 May 2002 19:49:51 -0400
> 
>    On Sun, May 19, 2002 at 09:40:53PM -0700, David S. Miller wrote:
>    > If other platforms added PTRACE_READDATA support, they would
>    > also need to add some way to do a feature test for it's presence
>    > so that GDB and other debugging code could actually make use
>    > of it portably.
>    
>    Not really, we should just get EINVAL (ENOSYS?) back when we try to use
>    it, right?
> 
> You'd get -EIO, but otherwise yes you are right.

Really?  That's inconvenient; the same result as for an invalid memory
address.

Oh well, it can still be worked around in GDB.  I'd like to see this on
more/all architectures.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
