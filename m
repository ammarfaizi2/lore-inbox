Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277406AbRJEPUt>; Fri, 5 Oct 2001 11:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277409AbRJEPUi>; Fri, 5 Oct 2001 11:20:38 -0400
Received: from robur.slu.se ([130.238.98.12]:49930 "EHLO robur.slu.se")
	by vger.kernel.org with ESMTP id <S277406AbRJEPU0>;
	Fri, 5 Oct 2001 11:20:26 -0400
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15293.53328.435292.971669@robur.slu.se>
Date: Fri, 5 Oct 2001 17:22:56 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@alex.org.uk, mingo@elte.hu, hadi@cyberus.ca (jamal),
        linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru (Alexey Kuznetsov),
        Robert.Olsson@data.slu.se (Robert Olsson),
        bcrl@redhat.com (Benjamin LaHaise), netdev@oss.sgi.com,
        torvalds@transmeta.com (Linus Torvalds),
        sim@netnation.com (Simon Kirby)
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <E15pGhY-0004Qz-00@the-village.bc.nu>
In-Reply-To: <302737894.1002234496@[195.224.237.69]>
	<E15pGhY-0004Qz-00@the-village.bc.nu>
X-Mailer: VM 6.92 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox writes:

 > You only think that. After a few minutes the kiddie pulls down your routing
 > because your route daemons execute no code. Also during the attack your sshd
 > wont run so you cant log in to find out what is up

Indeed.

I have a real example from a university core router with BGP and full 
Internet routing. I managed to get in via ssh during the DoS attack. 
We see that the 5 min dropping rate is about the same as the input 
rate. The duration of this attack was more half an hour and BGP survied 
and the box was pretty manageable. This was with a hacked tulip driver 
switching to RX-polling at high loads.
 
eth2: UP Locked MII Full DuplexLink UP
Admin up    6 day(s) 13 hour(s) 47 min 51 sec 
Last input  NOW
Last output NOW
5min RX bit/s   23.9 M
5min TX bit/s   1.1 M
5min RX pkts/s  46439        
5min TX pkts/s  759          
5min TX errors  0            
5min RX errors  0            
5min RX dropped 47038        
5min TX dropped 0            
5min collisions 0            

Well, this was a router but I think we very soon have the same demands for
most Internet servers.

Cheers.
						--ro


