Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289063AbSAIWgw>; Wed, 9 Jan 2002 17:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289056AbSAIWgH>; Wed, 9 Jan 2002 17:36:07 -0500
Received: from are.twiddle.net ([64.81.246.98]:19844 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S289063AbSAIWf0>;
	Wed, 9 Jan 2002 17:35:26 -0500
Date: Wed, 9 Jan 2002 14:35:25 -0800
From: Richard Henderson <rth@twiddle.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __FUNCTION__
Message-ID: <20020109143525.A3983@twiddle.net>
Mail-Followup-To: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3C3B664B.3060103@intel.com> <20020108220149.GA15816@kroah.com> <20020108235649.A26154@xs4all.nl> <20020108231147.GA16313@kroah.com> <20020108181202.A986@twiddle.net> <20020109072313.GA18359@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020109072313.GA18359@kroah.com>; from greg@kroah.com on Tue, Jan 08, 2002 at 11:23:13PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 11:23:13PM -0800, Greg KH wrote:
> On Tue, Jan 08, 2002 at 06:12:02PM -0800, Richard Henderson wrote:
> > __FUNCTION__ was never a string literal in g++ because you can't decide
> > what the name of a template is until you instantiate it.
> 
> According to the info page it was:
> 	   The compiler automagically replaces the identifiers with a
> 	   string literal containing the appropriate name. 

The info page lied.  This was true for C, but not C++.

> So, if you are going to change this (well, sounds like it is already
> done),

No, not done yet.  Just warning now -- the feature still works (in C).

> what is the timeline from taking a well documented feature and
> breaking it (based on the example in the info page)?  First a warning,
> and then an error, right?

Correct.  The first gcc version to warn is 3.0.3, released Dec 20, 2001,
The feature will be removed in 3.2, due Oct 15, 2002 if everything goes
according to schedule.


r~
