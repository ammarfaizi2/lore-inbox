Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262003AbSJ2QSN>; Tue, 29 Oct 2002 11:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbSJ2QSN>; Tue, 29 Oct 2002 11:18:13 -0500
Received: from air-2.osdl.org ([65.172.181.6]:18106 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262003AbSJ2QSL>;
	Tue, 29 Oct 2002 11:18:11 -0500
Message-Id: <200210291624.g9TGOUr31626@mail.osdl.org>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: Re: [BENCHMARK] AIM Independent Resource Benchmark results for 
 kernel-2.5.44
In-Reply-To: Message from Nathan Straz <nstraz@sgi.com> 
   of "Tue, 29 Oct 2002 09:28:00 CST." <20021029152800.GB2030@sgi.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 29 Oct 2002 08:24:30 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Oct 29, 2002 at 12:17:38AM +0100, Jakob Oestergaard wrote:
> > On Mon, Oct 28, 2002 at 12:28:39PM -0600, Nathan Straz wrote:
> > > > The AIM7/AIM9 new_raph is broken code.  The convergence loop termination
> > > > conditional looks something like:
> > > >    if (delta == 0) break;
> > > > for a type "double" delta.  You ought to change that to be something
> > > > like:
> > > >    if (delta <= 0.00000001L) break;
> > > 
> > > I usually specify the compiler flag -ffloat-store and that fixes the
> > > issue for me.  
> > 
> > Maybe that will work as a work-around.  But it is nothing but a
> > work-around. The previous poster was right - the code is broken.
> 
> /me looks at the code
> 
> 	/*
> 	 * Step 4: if |p - p0| < TOL then terminate successfully
> 	 */
> 	delta = fabs(p - p0);
> 	if (delta == 0.0)
> 		break;
> 
> Ok, I'll admit that the code does look broken, especially with regard to
> the comment *in* the code.  
> 
> Is anyone from Caldera still maintaining this code or shall I create a
> CVS module as part of LTP?
> 
The OSDL is interested in this supporting this test also. 
Appreciate the fix. 
cliffw
www.osdl.org

> -- 
> Nate Straz                                              nstraz@sgi.com
> sgi, inc                                           http://www.sgi.com/
> Linux Test Project                                  http://ltp.sf.net/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


