Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268244AbUHKVvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268244AbUHKVvT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 17:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268247AbUHKVvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 17:51:19 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:19160 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S268244AbUHKVvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 17:51:14 -0400
Date: Wed, 11 Aug 2004 23:51:06 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Len Brown <len.brown@intel.com>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc4-mm1 doesn't boot
Message-ID: <20040811215105.GK26174@fs.tum.de>
References: <566B962EB122634D86E6EE29E83DD808182C2B33@hdsmsx403.hd.intel.com> <1092259920.5021.117.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092259920.5021.117.camel@dhcppc4>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 05:32:00PM -0400, Len Brown wrote:
> I've never understood this floppy IRQ6 business.
> Apparently it requests IRQ6, but doesn't show up in /proc/interrupts
> 
> In any case, dropping a PCI interrupt on IRQ6 would surely break it
> b/c that would set that IRQ6 to level trigger.
> 
> Before this change, did LNKD get set to something other than IRQ6?

Yes, this is my 2.6.8-rc3-mm1 /proc/interrupts :

<--  snip  -->

           CPU0       
  0:   17615908          XT-PIC  timer
  1:      22333          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  6:      94751          XT-PIC  eth0
  8:          4          XT-PIC  rtc
  9:          0          XT-PIC  acpi
 10:       5119          XT-PIC  ehci_hcd
 11:    1329292          XT-PIC  Ensoniq AudioPCI, radeon@PCI:1:0:0
 12:     118130          XT-PIC  i8042
 14:      44614          XT-PIC  ide0
 15:         24          XT-PIC  ide1
NMI:          0 
ERR:          8

<--  snip  -->


> -Len

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

