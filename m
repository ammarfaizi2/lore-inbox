Return-Path: <linux-kernel-owner+w=401wt.eu-S1762549AbWLJUlu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762549AbWLJUlu (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 15:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762551AbWLJUlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 15:41:50 -0500
Received: from ref.nmedia.net ([66.39.177.2]:22001 "EHLO ref.nmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762533AbWLJUlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 15:41:49 -0500
Date: Sun, 10 Dec 2006 12:41:47 -0800 (PST)
From: Shaun Q <shaun@capcentrefoods.com>
X-X-Sender: shaun@ref.nmedia.net
To: Alan Chandler <alan@chandlerfamily.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE support on Intel DG965SS
In-Reply-To: <200612101558.34005.alan@chandlerfamily.org.uk>
Message-ID: <Pine.BSO.4.64.0612101240180.1408@ref.nmedia.net>
References: <200612101558.34005.alan@chandlerfamily.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the same board and had the same problems.  It now seems to work for 
install from the 10.2 RC1 DVD (and I'd assume 10.2 Final).  the 2.6.19 
kernel tree has support also, you have to find it under the new libata 
settings though ("Marvell PATA" controller)

Shaun

On Sun, 10 Dec 2006, Alan Chandler wrote:

> I have been trying to find out if the kernel supports the IDE channel
> (with a DVD/CD-R unit attached) on my Intel DG965SS motherboard.
>
> Searching the web indicates that for some motherboards based in the
> Intel 965 chipset success has been had for 2.6.18 onward by using the
> kernel boot parameters
>
> all-generic-ide pci=nommconf
>
> Although these were Fedora Core 6.
>
> I normally run Debian Unstable - but I have built 2.6.19 and installed
> that (using the Debian .config as the base config) - mainly because to
> get graphics to work it needs 2.6.19 to recognise the ids for the
> agpgart module.
>
> However, despite every thing else working - I can't get the IDE
> controller to be recognised - whether or not I use the above kernel
> boot parameters. I have been UNABLE to find what all-generic-ide does -
> it doesn't seem to be documented anywhere, so I was just blindly
> following someones instructions..
>
> lspci -v shows the following
>
> 02:00.0 IDE interface: Marvell Technology Group Ltd. Unknown device 6101
> (rev b1) (prog-if 8f [Master SecP SecO PriP PriO])
>        Subsystem: Marvell Technology Group Ltd. Unknown device 6101
>        Flags: bus master, fast devsel, latency 0, IRQ 10
>        I/O ports at 1018 [size=8]
>        I/O ports at 1024 [size=4]
>        I/O ports at 1010 [size=8]
>        I/O ports at 1020 [size=4]
>        I/O ports at 1000 [size=16]
>        Memory at 50100000 (32-bit, non-prefetchable) [size=512]
>        Capabilities: [48] Power Management version 2
>        Capabilities: [50] Message Signalled Interrupts: Mask- 64bit-
> Queue=0/0 Enable-
>        Capabilities: [e0] Express Legacy Endpoint IRQ 0
>
>
> Poking about in
>
> /sys/devices/pci0000:00/0000:00:02.0
>
> Reveals a vendor and subsystem vendor ID of 0x8086 - which is Intel, and
> a subsystem_device of 0x514d.
>
> I had a look in include/linux/pci_ids.h but all I could find there was
>
> #define PCI_DEVICE_ID_ATI_RADEON_QM     0x514d
>
> which doesn't appear related.
>
> Can anyone help me, as to where I can go from here?
>
>
> -- 
> Alan Chandler
> http://www.chandlerfamily.org.uk
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
