Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293416AbSCARWB>; Fri, 1 Mar 2002 12:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293423AbSCARVv>; Fri, 1 Mar 2002 12:21:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:63751 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293416AbSCARVh>; Fri, 1 Mar 2002 12:21:37 -0500
Subject: Re: Multiple kernels OOPS at boot on Fujitsu pt510 ( AMD DX100 CPU ) - ksymoops output attached
To: mallum@xblox.net (Matthew Allum)
Date: Fri, 1 Mar 2002 17:36:32 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C7F93B6.904@xblox.net> from "Matthew Allum" at Mar 01, 2002 02:44:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16gqxM-0004LV-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Id really appreciate some help on this matter. Theres plenty of these 
> 510's on ebay at the moment going very cheapy ( 100$) and they'd make 
> nice wireless 'web pads'.

I have a somewhat older beast (Fujitsu Stylistic 1000) which is somewhat
older and a little lower spec that I've been playing with a fair bit getting
Xfce + scribble etc running on with no problem.

Generally when you get a crash very early you want to check
	-CPU type the kernel was built with - your oops isnt an illegal
	 instruction so thats not it
	-Disabling APM support
	-Disabling PnpBIOS support (-ac tree only)
	-Using mem=fooM where foo is a bit under what is fitted in case
	 the box lies about memory availability

That generally gets successes. You might also want to do a test boot 
with mem=6M in case the machine has something funky like a 15-16Mb Vesa
local bus magic hole in the address map.

Definitely looks a fun toy
