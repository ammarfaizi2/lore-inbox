Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317802AbSGaVcU>; Wed, 31 Jul 2002 17:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317814AbSGaVcU>; Wed, 31 Jul 2002 17:32:20 -0400
Received: from moutng.kundenserver.de ([212.227.126.170]:18653 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S317802AbSGaVcT>; Wed, 31 Jul 2002 17:32:19 -0400
X-KENId: 00002EB3KEN47D99429
Date: Wed, 31 Jul 2002 23:33:20 +0200
From: Thomas <thomas@mierau.org>
Subject: Re: Tyan K7X with AMD MP 2.4.19-rc3-ac4
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Thomas Mierau <tmi@wikon.de>, linux-kernel@vger.kernel.org
Message-Id: <3D4857A0.2040407@mierau.org>
References: <200207301421.18701.tmi@wikon.de> <1028038129.6725.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
User-Agent: Mozilla/5.0 (Windows; U; Win98; de-DE; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My machine is still not working.
I tried ...-ac5 too.
I did a little debugging. Everything seems to be detected correctly. I 
also changed the /proc/interrupts a little to see if and which IRQs are 
know to the system. IRQ's up to 21 are all IO-APIC or XT-PIC IRQ's so 
that part is fine. But I don't get any redirects

The IRQ's are distributed pretty even between the CPU's. eth1 on IRQ5 
shows just 1 IRQ and no change after pinging another of our servers. The 
data is transmitted thou, as I receive the ping on the other machine. 
The other one is also answering.
On my SMP machine I get an error that the IRQ can't be handled and that 
may be another device uses it.
There is no other device (as I stripped the machine down to nothing) The 
  printer is disabled in BIOS. PCI just shows eth1 on IRQ5. And ther is 
only one "action" in the IRQ setup.


During boot I looked at all IRQ's and printk'ed the "shared" which the 
system is checking they all show a "shared=0" --> single IRQ source.

I looked at other postings and all of them had the redirects. But all 
the Kernels were also 4GB kernels, while I am using the 64G Kernal as I 
have 4GB RAM + swap. Is there any sense in removing some RAM for testing 
or not

The issue with the freezing system is persistent. The only question is 
when. Compliling the kernel with standard "make" will hang up the system 
hard. Using the option "make -j" will work with no problem.


Alan Cox wrote:

> On Tue, 2002-07-30 at 13:21, Thomas Mierau wrote:
> 
>>Hi
>>
>>I am trying to get the above board to work. Somehow it doesn't.
>>I tried kernel  2.4.18, 2.4.19-rc3, 2.4.19-rc3-ac3 and of course the latest 
>>2.4.19-rc3-ac4
>>
>>The machine itself is "working" stable under 2.4.18 with a limited 
>>functionality (no network, no additional scsi ports, no printer, no usb ...)
>>
> 
> Start by disabling acpi support
> 
> 
> 
> 


