Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292954AbSBVTOc>; Fri, 22 Feb 2002 14:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292955AbSBVTOW>; Fri, 22 Feb 2002 14:14:22 -0500
Received: from rj.sgi.com ([204.94.215.100]:49566 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S292954AbSBVTOJ>;
	Fri, 22 Feb 2002 14:14:09 -0500
Date: Fri, 22 Feb 2002 11:14:04 -0800
From: Jesse Barnes <jbarnes@sgi.com>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] NUMA scheduling
Message-ID: <20020222111404.A1515593@sgi.com>
Mail-Followup-To: Mike Kravetz <kravetz@us.ibm.com>,
	lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20020222105606.C1575@w-mikek2.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020222105606.C1575@w-mikek2.des.beaverton.ibm.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 10:56:06AM -0800, Mike Kravetz wrote:
> Below is preliminary patch to implement some form of NUMA scheduling
> on top of Ingo's K3 scheduler patch for 2.4.17.  This is VERY early
> code and brings up some issues that need to be discussed/explored in
> more detail.  This patch was created to form a basis for discussion,
> rather than as a solution.  The patch was created for the i386 based
> NUMA system I have access to.  It will not work on other architectures.
> However, the only architecture specific code is a call to initialize
> some of the NUMA specific scheduling data structures.  Therefore, it
> should be trivial to port.

Ah, you beat me to it; I was working on code very similar to this when
I got your e-mail.  I think this sort of thing will address the
problem we've been seeing on machines with more than 16 cpus or so
(IDLE_REBALANCE_TICK is too small, flooding CPUs with load_balance
requests), as well as making numa scheduling a little more efficient.
I'll see if I can make it work on our platform and let you know how it
goes.

Jesse
