Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261432AbSJ1SW1>; Mon, 28 Oct 2002 13:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261448AbSJ1SW1>; Mon, 28 Oct 2002 13:22:27 -0500
Received: from [198.149.18.6] ([198.149.18.6]:63122 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S261432AbSJ1SWZ>;
	Mon, 28 Oct 2002 13:22:25 -0500
Date: Mon, 28 Oct 2002 12:28:39 -0600
From: Nathan Straz <nstraz@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] AIM Independent Resource Benchmark  results for kernel-2.5.44
Message-ID: <20021028182839.GA2030@sgi.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <fa.d95885v.1d14t8c@ifi.uio.no> <037101c27c84$70015ce0$9865fea9@PCJohn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <037101c27c84$70015ce0$9865fea9@PCJohn>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 05:12:56PM -0700, John Hawkes wrote:
> From: "Siva Koti Reddy" <siva.kotireddy@wipro.com>
> >     39 new_raph       Unable to solve equation in 100 tries. P =
> 1.5708, P0
> > = 1.5708, delta = 6.12574e-17
> > new_raph: Success
> >  *** Failed to execute new_raph  ***
> 
> The AIM7/AIM9 new_raph is broken code.  The convergence loop termination
> conditional looks something like:
>    if (delta == 0) break;
> for a type "double" delta.  You ought to change that to be something
> like:
>    if (delta <= 0.00000001L) break;

I usually specify the compiler flag -ffloat-store and that fixes the
issue for me.  

-- 
Nate Straz                                              nstraz@sgi.com
sgi, inc                                           http://www.sgi.com/
Linux Test Project                                  http://ltp.sf.net/
