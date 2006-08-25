Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWHYIUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWHYIUJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 04:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWHYIUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 04:20:09 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:5823 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S932148AbWHYIUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 04:20:07 -0400
Subject: Re: [RFC] maximum latency tracking infrastructure
From: Arjan van de Ven <arjan@linux.intel.com>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, len.brown@intel.com
In-Reply-To: <20060824222417.GA27504@srcf.ucam.org>
References: <1156441295.3014.75.camel@laptopd505.fenrus.org>
	 <20060824222417.GA27504@srcf.ucam.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 25 Aug 2006 10:19:45 +0200
Message-Id: <1156493985.3032.13.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 23:24 +0100, Matthew Garrett wrote:
> On Thu, Aug 24, 2006 at 07:41:35PM +0200, Arjan van de Ven wrote:
> 
> > +	/* the ipw2100 hardware really doesn't want power management delays
> > +	 * longer than 500usec
> > +	 */
> > +	modify_acceptable_latency("ipw2100", 500);
> > +
> 
> Hm. My BIOS claims that the C3 transition period is 85usec (and even my 
> C4 is 185) , but I've hit the error path where C3 gets disabled. Is this 
> really adequate? 

first of all that 500 is a bit of a guess on my side; James (the Intel
wireless guy) is on holiday so I couldn't get real numbers out of it.
But as proof of concept it's pretty ok :)

> Also, by the looks of it, the C3 disabling path is 
> still present - is it still theoretically necessary with the above, or 
> is this just a belt and braces approach?

the "problem" is that bioses lie about these numbers all the time as
well ;( (it's getting better but still).


Those numbers you gave, were those on batter or on AC ? (apparently for
the problem machines C3 latency goes WAY up when on battery, and then
the problem hits)
