Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270397AbTGRWxl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 18:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270404AbTGRWxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 18:53:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19851 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270397AbTGRWwy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 18:52:54 -0400
Message-ID: <3F187DB1.1040309@pobox.com>
Date: Fri, 18 Jul 2003 19:07:29 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Stefan Cars <stefan@snowfall.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: ICH5 SATA high interrupt/system load again...
References: <20030718233631.F31074@guldivar.globalwire.se>
In-Reply-To: <20030718233631.F31074@guldivar.globalwire.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Cars wrote:
> Hi!
> 
> I've seen the discussion regarding high interrupt / system load on the
> ICH5 SATA and I'm asking what todo about it if I can't put my BIOS into
> "normal" mode. This machine is an Dell Precision 360 and for some stupid
> reason they have for this model removed the possibility in the BIOS to
> change this sort of things (you can't change much really). I'm using
> 2.4.21-ac4. Just to extract a simple tar file brings the system load up
> and the computer is slow...
> 
> 
> Here is some info:
> tjatte:/import# cat /proc/interrupts
>            CPU0
>   0:     557725          XT-PIC  timer
>   1:        102          XT-PIC  keyboard
>   2:          0          XT-PIC  cascade
>   5:          0          XT-PIC  ehci_hcd
>   9:   16409116          XT-PIC  libata, usb-uhci, eth0


Hum... interesting.  I had seen reports of this before, but they were of 
the variety "drivers/ide has high load, libata doesn't".  So it seems 
intrinsic of the hardware, which is a useful data point.

Have you tried messing around with interrupt routing in BIOS setup? 
Since ATA, USB, and eth0 are all on the same interrupt, changing that 
may affect the situation positively.

	Jeff



