Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130895AbRAABQE>; Sun, 31 Dec 2000 20:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131247AbRAABPy>; Sun, 31 Dec 2000 20:15:54 -0500
Received: from omega.cisco.com ([171.69.63.141]:8695 "EHLO cisco.com")
	by vger.kernel.org with ESMTP id <S130895AbRAABPj>;
	Sun, 31 Dec 2000 20:15:39 -0500
Message-Id: <4.3.2.7.2.20010101114105.02922ef0@omega.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 01 Jan 2001 11:44:05 +1100
To: Jussi Hamalainen <count@theblah.org>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: path MTU bug still there?
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0012311601410.9994-100000@shodan.irccrew.org
 >
In-Reply-To: <Pine.LNX.4.30.0012311409390.14553-100000@uplift.swm.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At 05:28 PM 31/12/2000 +0200, Jussi Hamalainen wrote:
>On Sun, 31 Dec 2000, Mikael Abrahamsson wrote:
>
> > When the linux box does TCP to the outside it'll use the MTU of
> > the tunnel (default route is the tunnel) and thus works perfectly
> > (since TCP MSS will be set low enough to fit into the tunnel).
>
>In my case I can't access a problematic host even from the router
>box.
...
>17:19:46.126297 xxx.xxx.xxx.xxx.1029 > 206.96.221.6.80: S 
>2549095564:2549095564(0) win 32120 <mss 1460,sackOK,timestamp 
>649398[|tcp]> (DF)
...

i know that you've said previously that you've increased your MTU beyond 
1500, but can you validate that it is actually working?
ie. ping something on the other side of the GRE tunnel using a ping with 
total packet sizes equal to 1500?

alternatively, ensure that your application is capable of enforcing a MSS 
<1460 if this is shown to not be the case ..

http://www.cisco.com/warp/public/105/56.html contains some good information 
on some of the potential pitfalls of using tunnels.



cheers,

lincoln.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
