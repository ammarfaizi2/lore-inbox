Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273340AbRINI3p>; Fri, 14 Sep 2001 04:29:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273343AbRINI3g>; Fri, 14 Sep 2001 04:29:36 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:3852 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S273340AbRINI30>; Fri, 14 Sep 2001 04:29:26 -0400
Message-ID: <3BA1BF99.A0DEB08A@t-online.de>
Date: Fri, 14 Sep 2001 10:28:09 +0200
From: SPATZ1@t-online.de (Frank Schneider)
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.3-test i686)
X-Accept-Language: en
MIME-Version: 1.0
To: csaradap <csaradap@mihy.mot.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: testing PPP over null modem
In-Reply-To: <3BA18965.A5761CEE@mihy.mot.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

csaradap schrieb:
> 
> I thaink I have a PPP connection up and running  over a null modem. So
> can u tell me how to test the ppp setup. By running ifconfig I am
> getting the ppp* interface running but the number of packets received
> and sent remains constant...

Hello...

First you have to assign IP-adresses to the ppp*-devices, this can be
done automatically at connect (so its done when you connect via ppp to
an ISP), but yo can also do it by hand.

I would suggest to read "man ifconfig", as i know, it should work like
something:
ifconfig ppp0 <ip> netmask <mask> up

This on both sides of the ppp-link.

Read also "man pppd".

After you have the interfaces (test them by pinging your own ppp0-IP),
you should lay some routing to them, e.g. you can set the default route
to the ppp*-device, so every packet will be send to the other maschine:
route add default gw ppp0

After that you should be able to ping the other maschines ip over the
ppp-link. Then the packetcounter will increase.

Solong..
Frank.

--
Frank Schneider, <SPATZ1@T-ONLINE.DE>.                           
Microsoft isn't the answer.
Microsoft is the question, and the answer is NO.
... -.-
