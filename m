Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265996AbUHaAvU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265996AbUHaAvU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 20:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265978AbUHaAvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 20:51:20 -0400
Received: from [139.30.44.16] ([139.30.44.16]:29927 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S266009AbUHaAu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 20:50:58 -0400
Date: Tue, 31 Aug 2004 02:49:28 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Albert Cahalan <albert@users.sourceforge.net>
cc: john stultz <johnstul@us.ibm.com>, george anzinger <george@mvista.com>,
       Andrew Morton OSDL <akpm@osdl.org>,
       Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>,
       hirofumi@mail.parknet.co.jp, lkml <linux-kernel@vger.kernel.org>,
       voland@dmz.com.pl, nicolas.george@ens.fr, david+powerix@blue-labs.org
Subject: Re: [PATCH] Re: boot time, process start time, and NOW time
In-Reply-To: <1093912654.434.7022.camel@cube>
Message-ID: <Pine.LNX.4.53.0408310246260.5907@gockel.physik3.uni-rostock.de>
References: <87smcf5zx7.fsf@devron.myhome.or.jp>  <20040816124136.27646d14.akpm@osdl.org>
  <Pine.LNX.4.53.0408172207520.24814@gockel.physik3.uni-rostock.de> 
 <412285A5.9080003@mvista.com>  <1092782243.2429.254.camel@cog.beaverton.ibm.com>
  <Pine.LNX.4.53.0408180051540.25366@gockel.physik3.uni-rostock.de> 
 <1092787863.2429.311.camel@cog.beaverton.ibm.com>  <1092781172.2301.1654.camel@cube>
  <1092791363.2429.319.camel@cog.beaverton.ibm.com> 
 <Pine.LNX.4.53.0408180927450.14935@gockel.physik3.uni-rostock.de> 
 <20040819191537.GA24060@elektroni.ee.tut.fi>  <20040826040436.360f05f7.akpm@osdl.org>
  <Pine.LNX.4.53.0408261311040.21236@gockel.physik3.uni-rostock.de> 
 <Pine.LNX.4.53.0408310037280.5596@gockel.physik3.uni-rostock.de> 
 <1093909116.14662.105.camel@cog.beaverton.ibm.com> <1093912654.434.7022.camel@cube>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2004, Albert Cahalan wrote:

> On Mon, 2004-08-30 at 19:38, john stultz wrote:
> 
> > This isn't going to happen instantly by any means. I'm trying to
> > get the time of day rework finished as soon as I can, but I've
> > got the day job to do as well. In the mean time, we can staple gun
> > any user visible exported HZ/jiffies values so they are accurate
> > (using ACTHZ or gettimeofday), and also look into changing HZ to a
> > less error-ful value.  HZ=1001 has been suggested and looks quite  
> > promising (although /net/schec/estimator.c wants a power of 4).
> 
> Well, pick something else. Here's a list of choices with
> error under 0.0025%, in the 240..1300 range, that can be
> evenly divided by four.

I don't think this is the main issue. We are not talking about slight 
rounding errors that might (and in many places are) be accounted for,
but with real inconsistencies that arise whenever the system clock is
adjusted. This e.g. was the source of the 15 minutes error that I saw in 
my recent testing.

Tim
