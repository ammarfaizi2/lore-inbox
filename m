Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424803AbWKQAtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424803AbWKQAtY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 19:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424824AbWKQAtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 19:49:24 -0500
Received: from outmx002.isp.belgacom.be ([195.238.5.52]:5056 "EHLO
	outmx002.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1424803AbWKQAtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 19:49:23 -0500
Message-ID: <455D0717.4010407@trollprod.org>
Date: Fri, 17 Nov 2006 01:49:27 +0100
From: Olivier Nicolas <olivn@trollprod.org>
User-Agent: Thunderbird 2.0b1pre (X11/20061115)
MIME-Version: 1.0
To: "Lu, Yinghai" <yinghai.lu@amd.com>
CC: Linus Torvalds <torvalds@osdl.org>, Mws <mws@twisted-brains.org>,
       Jeff Garzik <jeff@garzik.org>, Krzysztof Halasa <khc@pm.waw.pl>,
       David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
References: <5986589C150B2F49A46483AC44C7BCA490720E@ssvlexmb2.amd.com>
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA490720E@ssvlexmb2.amd.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lu, Yinghai wrote:
> -----Original Message-----
> From: Olivier Nicolas [mailto:olivn@trollprod.org] 
> 
> 
>> IRQ 22 is disabled but snd_hda_intel seems to get a MSI interrupt! (It 
>> cannot be reproduced)
> 
>> 313:          0          1   PCI-MSI-edge      HDA Intel
> 
> Please try attached one, also build hda_intel into kernel directly if it
> is not.
> 
> YH
> 

ALSA is build directly in the kernel

messages: htt://olivn.trollprod.org/19-rc6/hda_intel_pci_intx_11162006.dmesg

cat /proc/interrupts
            CPU0       CPU1
   0:        627     164040   IO-APIC-edge      timer
   1:          5       1363   IO-APIC-edge      i8042
   6:          0          5   IO-APIC-edge      floppy
   7:          0          0   IO-APIC-edge      MOTU MTPAV
   8:          0          0   IO-APIC-edge      rtc
   9:          0          0   IO-APIC-fasteoi   acpi
  12:        142      39757   IO-APIC-edge      i8042
  14:          5       1725   IO-APIC-edge      ide0
  16:         34      45618   IO-APIC-fasteoi   libata, ohci1394, nvidia
  17:          0          4   IO-APIC-fasteoi   Bt87x audio, bttv0
  20:         84      30048   IO-APIC-fasteoi   libata
  21:          2        451   IO-APIC-fasteoi   HDA Intel, ehci_hcd:usb2
  22:          0          1   IO-APIC-fasteoi   libata, ohci_hcd:usb1
  23:          0          0   IO-APIC-fasteoi   libata
308:        179      63652   PCI-MSI-edge      eth1
309:          1         98   PCI-MSI-edge      eth1
310:          1        117   PCI-MSI-edge      eth1
311:        179      63673   PCI-MSI-edge      eth0
312:          0          0   PCI-MSI-edge      eth0
313:          0          1   PCI-MSI-edge      eth0
NMI:         84         72
LOC:     164581     164616
ERR:          0


cat /proc/asound/cards
  0 [Dummy          ]: Dummy - Dummy
                       Dummy 1
  1 [VirMIDI        ]: VirMIDI - VirMIDI
                       Virtual MIDI Card 1
  2 [port           ]: MTPAV - MTPAV on parallel port
                       MTPAV on parallel port at 0x378
  3 [Bt878          ]: Bt87x - Brooktree Bt878
                       Brooktree Bt878 at 0xfdffe000, irq 17
  4 [NVidia         ]: HDA-Intel - HDA NVidia
                       HDA NVidia at 0xfe020000 irq 313


