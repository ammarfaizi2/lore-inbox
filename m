Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262186AbSJFUzL>; Sun, 6 Oct 2002 16:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262184AbSJFUzK>; Sun, 6 Oct 2002 16:55:10 -0400
Received: from [213.187.195.158] ([213.187.195.158]:24302 "EHLO
	kokeicha.ingate.se") by vger.kernel.org with ESMTP
	id <S262183AbSJFUzJ>; Sun, 6 Oct 2002 16:55:09 -0400
To: lkml <linux-kernel@vger.kernel.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-net@vger.kernel.org,
       edward_peng@dlink.com.tw
Subject: DFE-580TX packet drop persist (Re: Linux 2.4.20-pre9)
References: <Pine.LNX.4.44L.0210032203570.6478-100000@freak.distro.conectiva>
From: Marcus Sundberg <marcus@ingate.com>
Date: 06 Oct 2002 23:00:40 +0200
In-Reply-To: <Pine.LNX.4.44L.0210032203570.6478-100000@freak.distro.conectiva>
Message-ID: <veu1jze0zr.fsf@inigo.ingate.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br> writes:

> Summary of changes from v2.4.20-pre8 to v2.4.20-pre9
> ============================================

>   o sundance net drvr: fix DFE-580TX packet drop issue, further reset_tx fixes (contributed by Edward Peng @ D-Link)

Hi,

I'm sorry to say that the packet drop issue is still not solved
with a DF580-TX using four of these chips:
        Class 0200: 1186:1002 (rev 12)
        Subsystem: 1186:1012

Sending bi-directional streams of UDP-packets with 200-byte payload
through the machine I get zero packet loss and 15% CPU usage with
either eepro100 or tulip-based cards. Using the DFE-580TX I get
15% packet loss and 25% CPU usage. Ifconfig also shows packets
being dropped:

eth1      Link encap:Ethernet  HWaddr 00:05:5D:E6:14:BE  
          inet addr:10.230.0.1  Bcast:10.230.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:2439797 errors:0 dropped:287381 overruns:0 frame:0
          TX packets:2461746 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          Interrupt:18 Base address:0xa400 

eth2      Link encap:Ethernet  HWaddr 00:05:5D:E6:14:BF  
          inet addr:10.230.1.1  Bcast:10.230.1.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:2463601 errors:0 dropped:286106 overruns:0 frame:0
          TX packets:2437637 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          Interrupt:19 Base address:0xa000 

//Marcus
-- 
---------------------------------------+--------------------------
  Marcus Sundberg <marcus@ingate.com>  | Firewalls with SIP & NAT
 Firewall Developer, Ingate Systems AB |  http://www.ingate.com/
