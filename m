Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317301AbSFLBgX>; Tue, 11 Jun 2002 21:36:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317302AbSFLBgW>; Tue, 11 Jun 2002 21:36:22 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:6662 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S317301AbSFLBgV>; Tue, 11 Jun 2002 21:36:21 -0400
Date: Tue, 11 Jun 2002 18:36:16 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_NR_CPUS, redux
Message-ID: <20020611183616.H856@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0206111917310.3521-100000@sharra.ivimey.org> <1023820116.22156.271.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 11:28:36AM -0700, Robert Love wrote:
> On Tue, 2002-06-11 at 11:21, Ruth Ivimey-Cook wrote:
> 
> > Perhaps it's just because I'm coming in late, but I cannot understand why
> > NR_CPUS cannot be as low as 4 by default, for all archs, and then in the
> > kernel boot messages, should more be found than is configured for a message is
> > emitted to say "reconfigure your kernel", and continue with the number it was
> > configured for. I personally only rarely see 2-way boxes, 4-way is pretty
> > rare, and anything more must surely count as very specialized.
> 
> Ugh let's stop this thread now.  Two points:
> 
> 	(a) imo, the kernel should support out-of-the-box the maximum
> 	    number of CPUs it can handle.  Be lucky we now have a
> 	    configure option to change that.  But that does not matter..
> 
> 	(b) Right now it is 32.  Now you can change it... if you want
> 	    to change the current behavior by _default_ why don't we
> 	    suggest that _after_ this is accepted into 2.5?  I.e., one
> 	    battle at a time.

By that logic CONFIG_SMP should be "y" by default.

Now i find the name NR_CPUS a bit misleading it seems that
this should be MAX_CPUS but "legacy is as legacy does".

Using the names i prefer i would suggest in *config we
replace CONFIG_SMP with CONFIG_MAX_CPUS and give it a
default of 1.  Then make CONFIG_SMP dependant on
CONFIG_MAX_CPUS > 1.  That way we avoid adding yet another
option. KISS for the users.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
