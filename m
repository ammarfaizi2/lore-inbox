Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbTB1No7>; Fri, 28 Feb 2003 08:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbTB1No7>; Fri, 28 Feb 2003 08:44:59 -0500
Received: from daimi.au.dk ([130.225.16.1]:62862 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S261292AbTB1No6>;
	Fri, 28 Feb 2003 08:44:58 -0500
Message-ID: <3E5F6A43.6C1FE5F5@daimi.au.dk>
Date: Fri, 28 Feb 2003 14:55:15 +0100
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-19.7.xsmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] netconsole
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For debuging some Oops+panic I have been needing Mingo's neconsole patch
which I found on http://people.redhat.com/mingo/netconsole-patches/.
The patch seems quite old, it is for 2.4.10, and it did require a litle
work to get applied on latest kernels. Is there a more recent version in
another location I don't know about?

I got it working with 2.4.20, but unfortunately my sis900 was not
supported. However it was trivial to update sis900 to work with netconsole,
I simply made exactly the same modifications as the original patch did to
the tulip and the eepro100 driver. The result is here:
http://www.daimi.au.dk/~kasperd/linux_kernel/netconsole-2.4.20.patch

Now I have a few questions:
1) When it is so trivial to add support for another ethernet interface,
   how come there are so few supported? Is there some potential problem,
   I don't know about? In my case it certainly worked well enough for me
   to actually get the message on another computer, and that was from an
   Oops happening inside an IRQ which is if I understood it correctly one
   of the most tricky contexts.
2) Why does netconsole require the interface to have an IP address?
   Wouldn't it be possible to specify the source IP address as argument
   for the module? I´d like to do that to load the netconsole module
   early.
3) Would it be realistic to implement netconsole support for ethernet
   cards connected through USB? I have a SB4100 cable modem using the
   CDCEther driver.
4) Would it be possible to implement a SysRq key to repeat the mesages
   from the kernel buffer? This could be nice if the message got lost
   due to network congestion or because the receiving computer was turned
   off at the moment the crash happened.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
for(_=52;_;(_%5)||(_/=5),(_%5)&&(_-=2))putchar(_);
