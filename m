Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130324AbRBMFvY>; Tue, 13 Feb 2001 00:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130350AbRBMFvP>; Tue, 13 Feb 2001 00:51:15 -0500
Received: from kea.grace.cri.nz ([131.203.4.51]:20753 "EHLO kea.grace.cri.nz")
	by vger.kernel.org with ESMTP id <S130324AbRBMFvD>;
	Tue, 13 Feb 2001 00:51:03 -0500
Date: Tue, 13 Feb 2001 00:50:53 -0500 (EST)
Message-Id: <200102130550.AAA06620@whio.grace.cri.nz>
From: roger@kea.grace.cri.nz
To: ttsig@tuxyturvy.com
CC: linux-kernel@vger.kernel.org, roger@kea.grace.cri.nz, R.Bain@comnet.co.nz
In-Reply-To: <982037420.3a88b3ac6fbca@eargle.com> (message from Tom Sightler on Mon, 12 Feb 2001 23:10:20 -0500 (EST))
Subject: Re: Problem with Netscape/Linux v.2.4.x [repeat] (MTU problem??)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Re: Tom's message (below)


Thanks for your comments and description of symptoms. There may well
be an underlying common cause. Have you looked at the MTU/MSS
settings? 
 

>Do you get errors on your ppp0 interface?  Just curious.  Now that I know I'm 
>not just crazy maybe I'll look into it more.

I get a large number of RX errors (25%) when running telnet in console
mode (and very poor performance). Again this is confined to the 2.4.x
kernel. Oddly enough (with 2.4.x) there is little packet loss with telnet
under X. Similarly during a Netscape session (locked or not) there is
little packet loss registered....


Roger Young.

...........................................................................
Quoting roger@maths.grace.cri.nz:

> Symptoms: The browser (Netscape or Lynx) will not download from remote
> web sites (dynamic ppp connection via external modem).
> 
> This looks to be a problem for my PC and the 2.4.x kernel,

It is very interesting that your are having this problem.  I have been having a 
similar problem with with 2.4.x on my laptop and had been unable to totally put 
it all together.  Here's my basic symtoms:

I can use the web quite normally for quite some time, but certain sites seem to 
be a trigger.  For example, if I go to IBM site and attempt to download they're 
JDK I immediately start getting errors on my ppp0 interface.  From that point 
on I get errors on other sites that previously were working, and the ppp0 
errors continue to increase throughout the entire duration of the call.  If I 
hang up and dial back everything goes back to normal again until I attempt to 
connect to the IBM download site again.

I originally thought this was a problem with my Xircom adapter, but if I fire 
up VMware I can use Windows 2000 to dial the same link and everything works 
fine to all the same sites.  This certainly implies that the serial layer is 
working properly since VMware still simply passes control of /dev/ttyS1 to the 
VM.

I was unable to reproduce this problem on the same system with kernel 2.2.18, 
all other things being the same.  I don't think my ISP uses trasparent proxies, 
but it is possible the remote IBM system uses some transparent web 
accelerator/load balancer.  Most of the IBM web site works properly, only the 
software download site seems to trigger the problem.  The problem does exhibit 
itself on other sites, but the IBM site is where began to realize it was 
repeatable.

Do you get errors on your ppp0 interface?  Just curious.  Now that I know I'm 
not just crazy maybe I'll look into it more.

Later,
Tom
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
