Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266544AbRGDJQY>; Wed, 4 Jul 2001 05:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266546AbRGDJQN>; Wed, 4 Jul 2001 05:16:13 -0400
Received: from scan2.fhg.de ([153.96.1.37]:697 "EHLO scan2.fhg.de")
	by vger.kernel.org with ESMTP id <S266544AbRGDJP6>;
	Wed, 4 Jul 2001 05:15:58 -0400
Message-ID: <3B42DEC2.AAB1E65B@N-Club.de>
Date: Wed, 04 Jul 2001 11:15:46 +0200
From: Juergen Wolf <JuWo@N-Club.de>
Organization: FeM e.V.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
MIME-Version: 1.0
To: John Jasen <jjasen@datafoundation.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with SMC Etherpower II + kernel newer 2.4.2
In-Reply-To: <Pine.LNX.4.30.0107021014230.15054-100000@flash.datafoundation.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Jasen wrote:
> 
> a) bad cable? 
> b) not negotiating speed and duplex with the switch correctly? 
> c) bad card? 
>

Hi,

 The same errors show up with the network cable plugged or unplugged on
all computers with the SMC card around here. But all these computers are
equipped with nearly the same hardware (see my first posting of the
/proc/pci file). Also the 2.4.6 kernel does not solve the problem.  


> d) IRQ sharing causing a conflict? 

 I dont think so, at least I dont get a IRQ conflict message and there
is no other device shown as using the same interrupt. If I use the 2.4.2
kernel or a version below everything works fine on the same host.

Another strange effect is, that if I wait for quite some time (5-10
Minutes) while trying to start up the eth0 device with  "ifconfig eth0
up"  I see messages like

Jul  4 09:38:58 localhost kernel: eth0: Setting full-duplex based on MII
#3 link partner capability of 41e1.
Jul  4 09:39:00 localhost kernel: NETDEV WATCHDOG: eth0: transmit timed
out
Jul  4 09:39:00 localhost kernel: eth0: Transmit timeout using MII
device, Tx status 000b.
Jul  4 09:39:02 localhost kernel: eth0: Too much work at interrupt,
IntrStatus=0x008d0004.
Jul  4 09:40:55 localhost kernel: eth0: Setting half-duplex based on MII
#3 link partner capability of 0001.

in between hundreds of "too much work at interrupt" messages. This error
also occures regardles of the network cable is plugged or unplugged.

Regards
	Juergen
