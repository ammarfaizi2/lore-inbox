Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130985AbQKATVf>; Wed, 1 Nov 2000 14:21:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130525AbQKATVZ>; Wed, 1 Nov 2000 14:21:25 -0500
Received: from animal.cs.chalmers.se ([129.16.225.30]:10959 "EHLO
	animal.cs.chalmers.se") by vger.kernel.org with ESMTP
	id <S130985AbQKATVP>; Wed, 1 Nov 2000 14:21:15 -0500
Date: Wed, 1 Nov 2000 20:21:07 +0100 (MET)
From: Dennis Bjorklund <dennisb@cs.chalmers.se>
To: linux-kernel@vger.kernel.org
Subject: Broadcast
Message-ID: <Pine.SOL.4.21.0011012010340.19399-100000@muppet17.cs.chalmers.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to turn of the broadcast flag for a network card. But I
can't, why??

I have two network-cards in the machine and an application (rwhod) that
wants to send it's messages out on every interface that can broadcast. But
never want to broadcast anything on this interface so why not turn it
of? If I could that is..

This is what happens:

$ ifconfig eth1
eth1      Link encap:Ethernet  HWaddr 00:50:BA:6E:76:63  
          inet addr:192.168.0.1  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:143190 errors:0 dropped:194 overruns:0 frame:0
          TX packets:143584 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          Interrupt:9 Base address:0xe400 

$ ifconfig eth1 -broadcast
$ ifconfig eth1
eth1      Link encap:Ethernet  HWaddr 00:50:BA:6E:76:63  
          inet addr:192.168.0.1  Bcast:192.168.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:143228 errors:0 dropped:194 overruns:0 frame:0
          TX packets:143622 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100 
          Interrupt:9 Base address:0xe400 

As you can see. It still says BROADCAST.

This is on the 2.2.16 kernel and

$ ifconfig -V
net-tools 1.54
ifconfig 1.39 (1999-03-18)

/Dennis

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
