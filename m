Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262558AbTK1QJT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 11:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262566AbTK1QJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 11:09:19 -0500
Received: from mail6.bluewin.ch ([195.186.4.229]:53701 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S262558AbTK1QJR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 11:09:17 -0500
From: Raffaele Sandrini <rasa@gmx.ch>
Subject: System clock and speedstepping
Date: Fri, 28 Nov 2003 17:09:08 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200311261943.38002.rasa@gmx.ch>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm running here a dell inspirion 5150 with a P4 with Kernel 2.6.0-t9.
My problem is: If the laptop is running on bateries and the system is not idle 
the system clock (i dont think the hardware clock too) runns min twice as 
fast as it should (if not 4 times as fast as it should).

I first recognized it when i ran KDE (and we all know that KDE is not known 
for 
beeing tight on recources :) ) that the clock runs too fast when running from  
bateries.

Perhapps some words about my system. Without manually changing the CPU freq 
the system runs on AC const. 3 GHZ. On battries 1.6 GHZ const (i dont know if 
its 
really const on batteries i assume that there is a kind of hardware 
stepping).

I tried many kernel options RTC and HPET. The result was the same every time: 
When im running on bats in the console doing nothing the clock runs correct. 
If i execute this simple programm:
main () {
	while(1) {}
}
then the clock runns too fast.

I am able to step my CPU via the software interface CPUFREQ of the kernel (via 
the P4 clockmod driver). After some playing around i recognized that if i set 
the CPU freq to a very low value (e.g 100 MHZ) i get this msg on the console:
<msg>
Losing too many ticks!
TSC cannot be used as a timesource. (Are you running with SpeedStep?)
Falling back to a sane timesource.
</msg>
The funny thing is: After this msg the clock is running correct. I can set my 
CPU freq to what i want and load my system as much i want with a corect 
clock.

I don't know what "sane timesource" and "TSC" is. I also dont know where 
exaclty the problem is. I solved for the moment with an init script which 
checks if the laptop is running on bats and if so its stepping the system 
down for a sec and up again to force the above error to come. I know that 
this is a VERY dirty solution but i see know other way around this for the 
moment :(.

I tried to explain the problem as good as i can... I thought this should be 
postet here as this is surly a kernel issue. If you need more info ill try to 
provide these.

cheers,
Raffaele 
-- 
Raffaele Sandrini <rasa@gmx.ch>

