Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265115AbRFZVpJ>; Tue, 26 Jun 2001 17:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265117AbRFZVo7>; Tue, 26 Jun 2001 17:44:59 -0400
Received: from amadeus.resilience.com ([209.245.157.29]:2398 "HELO jmcmullan")
	by vger.kernel.org with SMTP id <S265115AbRFZVop>;
	Tue, 26 Jun 2001 17:44:45 -0400
Date: Tue, 26 Jun 2001 17:29:13 -0400
From: Jason McMullan <jmcmullan@linuxcare.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Jason McMullan <jmcmullan@linuxcare.com>, linux-kernel@vger.kernel.org
Subject: Re: VM Requirement Document - v0.0
Message-ID: <20010626172913.A29829@jmcmullan.resilience.com>
In-Reply-To: <20010626155838.A23098@jmcmullan.resilience.com> <Pine.LNX.4.33L.0106261819400.23373-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <Pine.LNX.4.33L.0106261819400.23373-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Tue, Jun 26, 2001 at 06:21:21PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2001 at 06:21:21PM -0300, Rik van Riel wrote:
> > 	* If we're getting low cache hit rates, don't flush
> > 	  processes to swap.
> > 	* If we're getting good cache hit rates, flush old, idle
> > 	  processes to swap.
> 
> ... but I fail to see this one. If we get a low cache hit
> rate, couldn't that just mean we allocated too little memory
> for the cache ?

	Hmmm. I didn't take that into consideration. But at the
same time, shouldn't a VM be able to determine that its cache
strategy is causing _more_ (absolute) misses by increasing it 
cache size? The percentage of misses may go down, but total 
device I/O may stay the same.

	So let's see... I'll rephrase that 'Motiviation' as:

	* Minimize the total medium/slow I/Os that occur over a 
	  sliding window of time. 

	Is that a more general case?
 
> Also, how would we translate all these requirements into
> VM strategies ?

	First, I would like to translate them into measurements.
Once we know how to measure these criteria, its possible to
formalize the feedback mechanism/accounting that a VM should
be aware of.

	In the end, I would like a VM to have some idea of
how well its performing, and be able to attempt various
well-known strategies based upon its own performance.

-- 
Jason McMullan, Senior Linux Consultant
Linuxcare, Inc. 412.432.6457 tel, 412.656.3519 cell
jmcmullan@linuxcare.com, http://www.linuxcare.com/
Linuxcare. Putting open source to work.
