Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVFMMD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVFMMD4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 08:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVFMMD4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 08:03:56 -0400
Received: from [195.23.16.24] ([195.23.16.24]:9181 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261514AbVFMMDv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 08:03:51 -0400
Message-ID: <42AD761C.6060709@grupopie.com>
Date: Mon, 13 Jun 2005 13:03:40 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] local_irq_disable removal
References: <Pine.LNX.4.44.0506111345400.12084-100000@dhcp153.mvista.com> <1118533485.13312.91.camel@tglx.tec.linutronix.de> <1118534993.5593.175.camel@sdietrich-xp.vilm.net> <200506112105.11067.gene.heskett@verizon.net>
In-Reply-To: <200506112105.11067.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:
> [...]
> Lets add the operation of 4 or more stepper motors in real time for 
> smaller milling machines.  There, the constraints are more related to 
> maintaining a steady flow of step/direction data at high enough 
> speeds to make a stepper, with 8 microsteps per step, and 240 steps 
> per revolution, run smoothly at speeds up to say 20 kilohertz, or 50 
> microseconds per step, maintaining that 50 microseconds plus or minus 
> not more than 5 microseconds else the motors will start sounding 
> ragged and stuttering.

This is the kind of problem that is screaming "give me dedicated 
hardware!". Why would one spend $500+ on a PC to do the work of a $2 
microcontroller (and possibly throw in an FPGA to the mix)?. Not to 
mention that the microcontroller/FPGA would maintain 50us +/- 0us 
instead of the 50 +/- 5 you've mentioned.

The same goes for the "hand under the saw". A simple 
transistor/triac/whatever and a logic circuit would stop the saw, we 
don't need any real time OS for that (and I would certainly trust the 
logic circuit more than any real time OS :).

IMHO, the kind of problems where real time OS's are useful are the kind 
that require computational power while having real-time constraints. 
Like the sound effects processor for the guitar that Lee Revell already 
mentioned or controlling an airplane in flight that has to measure a lot 
of sensors, do some state space calculations with some not-so-small 
matrices (together with Kalman filtering, etc.) and move the actuators.

-- 
Paulo Marques - www.grupopie.com

An expert is a person who has made all the mistakes that can be
made in a very narrow field.
Niels Bohr (1885 - 1962)
