Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272368AbTHOXND (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 19:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272381AbTHOXND
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 19:13:03 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:63361 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S272368AbTHOXM7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 19:12:59 -0400
Date: Sat, 16 Aug 2003 00:12:49 +0100
From: Jamie Lokier <jamie@shareable.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Charles Lepple <clepple@ghz.cc>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: PIT, TSC and power management [was: Re: 2.6.0-test3 "loosing ticks"]
Message-ID: <20030815231249.GE19707@mail.jlokier.co.uk>
References: <20030813014735.GA225@timothyparkinson.com> <1060793667.10731.1437.camel@cog.beaverton.ibm.com> <20030814171703.GA10889@mail.jlokier.co.uk> <1060882084.10732.1588.camel@cog.beaverton.ibm.com> <3F3C272E.7060702@ghz.cc> <1060969733.10731.1604.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060969733.10731.1604.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john stultz wrote:
> Well, depending on how ntp is compiled, it could use stime, rather then
> settimeofday. This causes ntp to set the time on average .5 seconds off
> the desired time. Since .5 is outside the .128 sec slew boundary, ntp 
> will do another step adjustment which has the same poor accuracy. This
> results in ntp just hopping back and forth around the desired time. 

On my more-or-less Red Hat 9 system, it would be quite surprising if
the ntpd which works with 2.4 suddenly stopped working...

Though it would be less of a surprise if ntpd had always had this
problem in this box, and I just didn't notice with 2.4.

-- Jamie
