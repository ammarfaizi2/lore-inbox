Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135704AbREFPVL>; Sun, 6 May 2001 11:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135709AbREFPVC>; Sun, 6 May 2001 11:21:02 -0400
Received: from [62.81.160.68] ([62.81.160.68]:13443 "EHLO smtp2.alehop.com")
	by vger.kernel.org with ESMTP id <S135704AbREFPUv>;
	Sun, 6 May 2001 11:20:51 -0400
Date: Sun, 6 May 2001 17:11:31 -0400
From: Ignacio Monge <ignaciomonge@navegalia.com>
To: Kernel List <linux-kernel@vger.kernel.org>,
        Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 8139too bug in 2.4.4 (2.4.3?) & VIA 686a
Message-Id: <20010506171131.4f309157.ignaciomonge@navegalia.com>
X-Mailer: Sylpheed version 0.4.65 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	It seem that I have resolved the problem. Yes, I've read 8139too.txt and
I thought to recheck my kernel 2.4.4 configuration.
	It looked this:
	CONFIG_NET_ETHERNET=y       
	CONFIG_NET_PCI=y    
	CONFIG_8139TOO=m   
	CONFIG_8139TOO_PIO=m
	CONFIG_8139TOO_TUNE_TWISTER=y
	CONFIG_8139TOO_8129=m
	
	Then, I've disabled PIO, and older RTl... 
	Looked like this:
	CONFIG_NET_ETHERNET=y                                                    
                           
	CONFIG_NET_PCI=y                                                         
                           
	# CONFIG_8139TOO_PIO is not set                                          
                           
	CONFIG_8139TOO=m                                                         
                           
	CONFIG_8139TOO_TUNE_TWISTER=y                                            
                          
 	# CONFIG_8139TOO_8129 is not set                                        
                            


And... Yeah, It works.
	The ifconfig is:
	eth0      Link encap:Ethernet  HWaddr 00:E0:29:9A:CB:62  
          inet addr:192.168.0.1  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:782 errors:0 dropped:0 overruns:0 frame:0
          TX packets:858 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          RX bytes:72449 (70.7 Kb)  TX bytes:1078928 (1.0 Mb)
          Interrupt:11 Base address:0xc000 

	Problem resolved. :)
	
