Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129402AbRBMEKt>; Mon, 12 Feb 2001 23:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129712AbRBMEKk>; Mon, 12 Feb 2001 23:10:40 -0500
Received: from 216-175-174-69.client.dsl.net ([216.175.174.69]:33807 "HELO
	frank.eargle.com") by vger.kernel.org with SMTP id <S129402AbRBMEKY>;
	Mon, 12 Feb 2001 23:10:24 -0500
To: roger@kea.grace.cri.nz
Subject: Re: Problem with Netscape/Linux v.2.4.x [repeat] (MTU problem??)
Message-ID: <982037420.3a88b3ac6fbca@eargle.com>
Date: Mon, 12 Feb 2001 23:10:20 -0500 (EST)
From: Tom Sightler <ttsig@tuxyturvy.com>
Cc: linux-kernel@vger.kernel.org, roger@kea.grace.cri.nz, dwmw2@infradead.org,
        R.Bain@comnet.co.nz
In-Reply-To: <200102130227.VAA06389@whio.grace.cri.nz>
In-Reply-To: <200102130227.VAA06389@whio.grace.cri.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
