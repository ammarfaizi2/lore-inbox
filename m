Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289380AbSBJIzt>; Sun, 10 Feb 2002 03:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289375AbSBJIzk>; Sun, 10 Feb 2002 03:55:40 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:49643 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S289362AbSBJIzZ>; Sun, 10 Feb 2002 03:55:25 -0500
Date: Sun, 10 Feb 2002 09:55:22 +0100
From: Marc Schiffbauer <marc.schiffbauer@links2linux.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: bert hubert <ahu@ds9a.nl>
Subject: Re: ingress policing still not working in 2.4?
Message-ID: <20020210085521.GA2153@links2linux.de>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	bert hubert <ahu@ds9a.nl>
In-Reply-To: <20020209114529.GA6753@links2linux.de> <20020210005636.A21350@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020210005636.A21350@outpost.ds9a.nl>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.17 i586
X-Editor: VIM 6.0
X-Homepage: http://www.links2linux.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* bert hubert schrieb am 10.02.02 um 00:56 Uhr:
> On Sat, Feb 09, 2002 at 11:48:50AM +0000, Marc Schiffbauer wrote:
> > RTNETLINK answers: No such file or directory
> 
> Get a newer tc, it appears to fix this problem.
> 

Yes, the debian unstable package did it, thanks.


> > Before that I successfully did this:
> > # install root CBQ
> > DEV=ppp0
> > UPLINK=100
> > DOWNLINK=750
> > tc qdisc add dev $DEV root handle 1: cbq avpkt 1000 bandwidth 100mbit
> 
> The WonderShaper! 
> 
What?

Ok, I changed the 10mbit to 100mbit because this is my LAN speed
here. I first didn't see, that the root handle is per device.

But
tc qdisc add dev $DEV root handle 1: cbq avpkt 1000 bandwidth 10mbit

is exactly the line from your HOWTO. So what will be proper values
for my DSL Line with 128kbit up and 768kbit downstream?

Regards
-Marc

-- 
BUGS My programs  never  have  bugs.  They  just  develop  random
     features.  If you discover such a feature and you want it to
     be removed: please send an email to bug@links2linux.de 
