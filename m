Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262480AbUKRPiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262480AbUKRPiV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 10:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbUKRPiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 10:38:20 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:4502 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262480AbUKRPiM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 10:38:12 -0500
Date: Thu, 18 Nov 2004 16:37:48 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Christian Meder <chris@onestepahead.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm1-V0.7.28-1
In-Reply-To: <1100791410.3397.15.camel@localhost>
Message-ID: <Pine.LNX.4.53.0411181634280.24023@yvahk01.tjqt.qr>
References: <20041106155720.GA14950@elte.hu> <20041108091619.GA9897@elte.hu>
  <20041108165718.GA7741@elte.hu> <20041109160544.GA28242@elte.hu> 
 <20041111144414.GA8881@elte.hu> <20041111215122.GA5885@elte.hu> 
 <20041116125402.GA9258@elte.hu> <20041116130946.GA11053@elte.hu> 
 <20041116134027.GA13360@elte.hu> <20041117124234.GA25956@elte.hu> 
 <20041118123521.GA29091@elte.hu> <1100791410.3397.15.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I've got one of those 'my box just locked up'. I can reproduce it with
>0.7.25-1, 0.7.28-0 and 0.7.28-1 by starting the Jetty servlet container
>with our inhouse java project under a Blackdown 1.4 jdk. Within a minute
>the laptop just locks up: no mouse, no ping, console switching sysrq-t

Sysrq+T itself might work, it's just a matter to get to the console! If you can
get to a con, I'm sure it does, because hitting the keys generates an interrupt
which will be delivered to the sysrq code if interrupts are not currently
disabled. So even if your box appears totally dead, you'd be surprised when you
hit Sysrq+B.

To get any data, I'd start a vnc server on it, and all graphical apps in it,
and let the machine itself stay on tty10 (or wherever kernel output goes), and
then try hitting Sysrq+T when it hangs.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
