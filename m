Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263763AbUDOQOl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 12:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264122AbUDOQOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 12:14:41 -0400
Received: from elektroni.ee.tut.fi ([130.230.131.11]:54145 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP id S263763AbUDOQOj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 12:14:39 -0400
Date: Thu, 15 Apr 2004 19:14:36 +0300
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: john stultz <johnstul@us.ibm.com>, george anzinger <george@mvista.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       David Ford <david+powerix@blue-labs.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: /proc or ps tools bug?  2.6.3, time is off
Message-ID: <20040415161436.GA21613@elektroni.ee.tut.fi>
Mail-Followup-To: Tim Schmielau <tim@physik3.uni-rostock.de>,
	john stultz <johnstul@us.ibm.com>,
	george anzinger <george@mvista.com>,
	Albert Cahalan <albert@users.sourceforge.net>,
	David Ford <david+powerix@blue-labs.org>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <403D0F63.3050101@mvista.com> <1077760348.2857.129.camel@cog.beaverton.ibm.com> <403E7BEE.9040203@mvista.com> <1077837016.2857.171.camel@cog.beaverton.ibm.com> <403E8D5B.9040707@mvista.com> <1081895880.4705.57.camel@cog.beaverton.ibm.com> <Pine.LNX.4.53.0404141353450.21779@gockel.physik3.uni-rostock.de> <1081967295.4705.96.camel@cog.beaverton.ibm.com> <20040415103711.GA320@elektroni.ee.tut.fi> <Pine.LNX.4.53.0404151302140.28278@gockel.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0404151302140.28278@gockel.physik3.uni-rostock.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2004 at 01:05:17PM +0200, Tim Schmielau wrote:
> On Thu, 15 Apr 2004, Petri Kaukasoina wrote:
> 
> > If we are still talking about the problem with ps showing process start 
> > times in future, I'm sorry neither of the patches helped. The error grows
> > here at a rate of 15 seconds in 24 hours as before.
> 
> Oops...
> sure, it cannot. Maybe this one is better...
> 
> 
> --- linux-2.6.5/include/linux/times.h	2004-02-04 04:43:09.000000000 +0100
> +++ linux-2.6.5-jfix1/include/linux/times.h	2004-04-15 12:59:05.000000000 +0200

Yes, it seems to have fixed it. There is a small error: ps shows a start
time of a new minute about four seconds too early, but the error stays
constant and does not change as a function of uptime any longer. (Actually
it still does but only at the same rate as ntpd corrects time.)

-Petri
