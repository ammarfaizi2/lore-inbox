Return-Path: <linux-kernel-owner+w=401wt.eu-S1751486AbXAKUZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751486AbXAKUZV (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 15:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbXAKUZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 15:25:21 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:13795 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbXAKUZU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 15:25:20 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nHd8pq/9QHKTeoPnX6Xxi+rjqUaF0aEwGcmvtn8WckP7OZXrBE0aroGpCm16zTeBmhDjKrICtMMd01BUCDbWZ//Rd+7HS25o4LeC4sXjoTbk5m4x2dwWOy7S49IN+Ln02R/57YS8kylgX2X44ZqaQeuziPeD7HIH2PFevKCew4Y=
Message-ID: <8355959a0701111225k28bd7dei4071231249d633f3@mail.gmail.com>
Date: Fri, 12 Jan 2007 01:55:18 +0530
From: "Sunil Naidu" <akula2.shark@gmail.com>
To: "Randy Dunlap" <randy.dunlap@oracle.com>
Subject: Re: Linux-2.6.20-rc4 - Kernel panic!
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20070111103237.16066096.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8355959a0701110300j33d28f54y67728eb847c7ba31@mail.gmail.com>
	 <20070111103237.16066096.randy.dunlap@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/12/07, Randy Dunlap <randy.dunlap@oracle.com> wrote:
>
> Size cannot be > 100 KB (and message cannot be html).
> If photo size is > 100 KB, can you post it on the web somewhere?
> (or email it me)

Shall e-mail you rightway, thanks.
OffTopic: pic was 145KB, any good tool to compress with ease without
much loss of quality on linux? Tried some, couldn't crop images
easily!

>
> > Error messages:
> >
> > mount: could not find file system  '/dev/root'
> > setuproot: moving /dev failed: No such file or directory
> > setuproot: error mountng /proc : No such file or directory
> > setuproot: error mountng /sys : No such file or directory
> > switchroot: mount failed: No such file or directory
> >
> > Could you please give a pointer on this panic? I did refer to gdb to
> > debug, it didn't help much. Any clues here how to proceed from here?
>
> Did some other previous kernel versions work/boot for you?
> With the same config file?

Yep, till September 2006 I was active with Kernel building with
another group in my Labs. I think I have built 2.6.18 sucessfully for
my IBM ThinkCentre A51 Workstation (Non HT) that time. Should I post
that .config here?

Now I have resumed Kernel building activities after a gap....all hell
broke loose for me....problems are cropping up with this P4-HT
machine!

I have compared my present .config with the distro's updated 2.6.18
kernel config, made changes. No differences. But I really wonder
what's wrong with my 2.6.19/2.6.20-rc4 building efforts :( I still
have one my Dual Core Laptop in the que, god knows...

>
> It looks like your new kernel doesn't have a driver for the boot
> device, or the initrd does not have that driver.

Is there any way to check that?  My lspci data:

[sukhoi@Typhoon sbin]$ ./lspci
00:00.0 Host bridge: Intel Corporation 82915G/P/GV/GL/PL/910GL Memory
Controller Hub (rev 04)
00:01.0 PCI bridge: Intel Corporation 82915G/P/GV/GL/PL/910GL PCI
Express Root Port (rev 04)
00:02.0 VGA compatible controller: Intel Corporation 82915G/GV/910GL
Integrated Graphics Controller (rev 04)
00:1b.0 Audio device: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) High Definition Audio Controller (rev 03)
00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) PCI Express Port 1 (rev 03)
00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) PCI Express Port 2 (rev 03)
00:1c.2 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) PCI Express Port 3 (rev 03)
00:1c.3 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) PCI Express Port 4 (rev 03)
00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #1 (rev 03)
00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #2 (rev 03)
00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #3 (rev 03)
00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB UHCI #4 (rev 03)
00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) USB2 EHCI Controller (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d3)
00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC
Interface Bridge (rev 03)
00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6
Family) IDE Controller (rev 03)
00:1f.2 IDE interface: Intel Corporation 82801FB/FW (ICH6/ICH6W) SATA
Controller (rev 03)
00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family)
SMBus Controller (rev 03)
06:00.0 Ethernet controller: MYSON Technology Inc SURECOM EP-320X-S
100/10M Ethernet PCI Adapter


> ~Randy
>

Thanks,

~Akula2
