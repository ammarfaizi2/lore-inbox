Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315748AbSE2XuR>; Wed, 29 May 2002 19:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315760AbSE2XuQ>; Wed, 29 May 2002 19:50:16 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:27636 "EHLO branoic")
	by vger.kernel.org with ESMTP id <S315748AbSE2XuQ>;
	Wed, 29 May 2002 19:50:16 -0400
Date: Wed, 29 May 2002 19:49:51 -0400
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
To: "David S. Miller" <davem@redhat.com>
Cc: ppadala@cise.ufl.edu, linux-kernel@vger.kernel.org
Subject: Re: No PTRACE_READDATA for archs other than SPARC?
Message-ID: <20020529234951.GA3797@branoic.them.org>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	ppadala@cise.ufl.edu, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.05.10205192307500.26915-100000@rain.cise.ufl.edu> <20020519.214053.19164382.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 19, 2002 at 09:40:53PM -0700, David S. Miller wrote:
>    From: Pradeep Padala <ppadala@cise.ufl.edu>
>    Date: Sun, 19 May 2002 23:08:36 -0400 (EDT)
> 
>       I was trying to understand ptrace code in kernel. It seems there's
>    no PTRACE_READDATA for architectures other than sparc and sparc64.
>    There's a function named ptrace_readdata() in kernel/ptrace.c but I
>    couldn't find a way to invoke it from user space. Is the feature
>    missing? or Is it intended?
> 
> Only Sparc implements this, that is correct.
> 
> If other platforms added PTRACE_READDATA support, they would
> also need to add some way to do a feature test for it's presence
> so that GDB and other debugging code could actually make use
> of it portably.

Not really, we should just get EINVAL (ENOSYS?) back when we try to use
it, right?

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
