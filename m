Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280475AbRJaUKa>; Wed, 31 Oct 2001 15:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280469AbRJaUIc>; Wed, 31 Oct 2001 15:08:32 -0500
Received: from 216-21-153-1.ip.van.radiant.net ([216.21.153.1]:60168 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S280471AbRJaUIS>;
	Wed, 31 Oct 2001 15:08:18 -0500
Date: Wed, 31 Oct 2001 12:11:18 -0800 (PST)
From: Gerhard Mack <gmack@innerfire.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Andreas Dilger <adilger@turbolabs.com>,
        Tim Schmielau <tim@physik3.uni-rostock.de>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Re: Nasty suprise with uptime
In-Reply-To: <Pine.LNX.3.95.1011031141239.20901A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.10.10110311206020.6571-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2001, Richard B. Johnson wrote:

> On Wed, 31 Oct 2001, Gerhard Mack wrote:
> 
> > Why exactly do we use the jiffie count for calculating uptime?  Why not
> > just record the startup time and compare when needed?
> > 
> > 
> > 	Gerhard
> > 
> Because you get it for free. The counter is necessary for time-outs
> so you need it. If it starts at zero, you get uptime in HZ.

Yes that I understand and it works right up until the jiffie count wraps.
But now we have people adding cost to everything else just so we can all
have good uptime values.  Since AFIK the drivers handle the wrap cleanly
the only thing that it bothers is the uptime stats.

Now we have people making jiffies more expensive just to deal with uptime.
At least as far as I can see it should just be easier/better to make
uptime use something else.

Or am I completly off base?


	Gerhard



--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

