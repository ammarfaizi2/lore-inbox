Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129189AbRBVI2j>; Thu, 22 Feb 2001 03:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129252AbRBVI2a>; Thu, 22 Feb 2001 03:28:30 -0500
Received: from tilde.ookhoi.dds.nl ([194.109.10.165]:896 "HELO
	humilis.ookhoi.dds.nl") by vger.kernel.org with SMTP
	id <S129189AbRBVI2Q>; Thu, 22 Feb 2001 03:28:16 -0500
Date: Thu, 22 Feb 2001 09:28:02 +0100
From: Ookhoi <ookhoi@dds.nl>
To: Jordan Mendelson <jordy@napster.com>
Cc: "David S. Miller" <davem@redhat.com>, Vibol Hou <vibol@khmer.cc>,
        Linux-Kernel <linux-kernel@vger.kernel.org>, sim@stormix.com
Subject: Re: 2.4 tcp very slow under certain circumstances (Re: netdev issues (3c905B))
Message-ID: <20010222092802.B405@humilis>
Reply-To: ookhoi@dds.nl
In-Reply-To: <HDEBKHLDKIDOBMHPKDDKMEGDEFAA.vibol@khmer.cc> <20010221104723.C1714@humilis> <14995.40701.818777.181432@pizda.ninka.net> <3A94418D.A0DD99BF@napster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3A94418D.A0DD99BF@napster.com>; from jordy@napster.com on Wed, Feb 21, 2001 at 02:30:37PM -0800
X-Uptime: 8:48am  up 5 min,  5 users,  load average: 0.25, 0.12, 0.05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jordan,

> >  > We have exactly the same problem but in our case it depends on the
> >  > following three conditions: 1, kernel 2.4 (2.2 is fine), 2, windows ip
> >  > header compression turned on, 3, a free internet access provider in
> >  > Holland called 'Wish' (which seemes to stand for 'I Wish I had a faster
> >  > connection').
> >  > If we remove one of the three conditions, the connection is oke. It is
> >  > only tcp which is affected.
> >  > A packet on its way from linux server to windows client seems to get
> >  > dropped once and retransmitted. This makes the connection _very_ slow.
> > 
> > :-( I hate these buggy systems.
> > 
> > Does this patch below fix the performance problem and are the windows
> > clients win2000 or win95?
> 
> I wanted to see if this would fix the problem I was seeing with Win9x
> users on PPP w/ compression dialing up to Earthlink in the bay area
> (there are others, but it's the only one I can reproduce).
> 
> I compiled 2.4.1 with this change and for some odd reason, the kernel
> started dropping packets and became unusable (couldn't ssh in) after
> around 4050 connections were opened. I tested it also with 2.4.1-ac20
> and had the same problem right around 4050 connections.
> 
> This is on a VA Linux box with dual eepro100's (one used) connected to a
> Cisco 6509.

I patched two computers, 2.4.1-ac20. One of them is a fairly loaded
webserver. Both have an uptime of 15.15 and 16.30 hours, and are fine.
Didn't test with that much connections though.

	Ookhoi
