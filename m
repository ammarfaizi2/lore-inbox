Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129588AbQKSHCD>; Sun, 19 Nov 2000 02:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131499AbQKSHBx>; Sun, 19 Nov 2000 02:01:53 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:14631 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129588AbQKSHBe>; Sun, 19 Nov 2000 02:01:34 -0500
Message-ID: <3A17739A.29AFFAC6@linux.com>
Date: Sat, 18 Nov 2000 22:30:51 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, David Hinds <dhinds@valinux.com>,
        linux-kernel@vger.kernel.org, "Theodore Y. Ts'o" <tytso@MIT.EDU>
Subject: [FIXED!] Re: [PATCH] pcmcia event thread. (fwd)
In-Reply-To: <Pine.LNX.4.10.10011182133240.3061-100000@cesium.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------9177FA5BFF333A319F8F33DB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------9177FA5BFF333A319F8F33DB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

It's time for a week long party!

It works great, interrupts are even delivered to the tulip handler :)

Attached is the boot dmesg in case any aesthetic changes are desired.

Ted, please scratch off the NEC Versa LX PCMCIA entries as fixed, I assume this patch will go in on the
next release.

MEGA thank yous,
-d

----
PCI: BIOS32 Service Directory structure at 0xc00fdb70
PCI: BIOS32 Service Directory entry at 0xfdb80
PCI: BIOS probe returned s=00 hw=01 ver=02.10 l=01
PCI: PCI BIOS revision 2.10 entry at 0xfdba1, last bus=1
PCI: Using configuration type 1
PCI: Probing PCI hardware
PCI: IDE base address fixup for 00:07.1
PCI: Scanning for ghost devices on bus 0
PCI: Scanning for ghost devices on bus 1
PCI: IRQ init
PCI: Interrupt Routing Table found at 0xc00f5a80
00:01 slot=00 0:60/0420 1:00/0000 2:00/0000 3:00/0000
00:03 slot=00 0:60/0420 1:61/0420 2:00/0000 3:00/0000
00:04 slot=00 0:61/0420 1:00/0000 2:00/0000 3:00/0000
00:05 slot=00 0:60/0420 1:00/0000 2:00/0000 3:00/0000
00:07 slot=00 0:fe/4000 1:ff/8000 2:00/0000 3:63/0200
00:11 slot=01 0:60/0420 1:61/0420 2:62/0800 3:61/0420
PCI: Using IRQ router PIIX [8086/7110] at 00:07.0
PCI: IRQ fixup
00:03.0: ignoring bogus IRQ 255
00:03.1: ignoring bogus IRQ 255
IRQ for 00:03.0(0) via 00:03.0 -> PIRQ 60, mask 0420, excl 0000 -> got IRQ 10
PCI: Found IRQ 10 for device 00:03.0
PCI: The same IRQ used for device 01:00.0
IRQ for 00:03.1(1) via 00:03.1 -> PIRQ 61, mask 0420, excl 0000 -> got IRQ 5
PCI: Found IRQ 5 for device 00:03.1
PCI: The same IRQ used for device 00:04.0
PCI: Allocating resources
PCI: Resource e0000000-efffffff (f=1208, d=0, p=0)
PCI: Resource 0000ec00-0000ecff (f=101, d=0, p=0)
PCI: Resource 0000ffa0-0000ffaf (f=101, d=0, p=0)
PCI: Resource 0000ef80-0000ef9f (f=101, d=0, p=0)
PCI: Resource fd000000-fdffffff (f=200, d=0, p=0)
PCI: Resource 0000dc00-0000dcff (f=101, d=0, p=0)
PCI: Resource feaff000-feafffff (f=200, d=0, p=0)
PCI: Sorting device list...
Limiting direct PCI/PCI transfers.

Linux PCMCIA Card Services 3.1.22
  options:  [pci] [cardbus] [pm]
Intel PCIC probe: not found.
Databook TCIC-2 PCMCIA probe: not found.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
Yenta IRQ list 0898, PCI irq10
Socket status: 30000860
Yenta IRQ list 0898, PCI irq5
Socket status: 30000046

cs: cb_alloc(bus 2): vendor 0x1011, device 0x0019
PCI: Enabling device 02:00.0 (0000 -> 0003)
Linux Tulip driver version 0.9.11 (November 3, 2000)
PCI: Setting latency timer of device 02:00.0 to 64
eth1: Digital DS21143 Tulip rev 65 at 0x1800, 00:E0:98:70:1E:AF, IRQ 10.
eth1:  EEPROM default media type Autosense.
eth1:  Index #0 - Media MII (#11) described by a 21142 MII PHY (3) block.
eth1:  MII transceiver #0 config 3000 status 7809 advertising 01e1.
call_usermodehelper[/sbin/hotplug]: no root fs



Linus Torvalds wrote:

> On Sat, 18 Nov 2000, David Ford wrote:
> > Linus Torvalds wrote:
> >
> > > Can you (you've probably done this before, but anyway) enable DEBUG in
> > > arch/i386/kernel/pci-i386.h? I wonder if the kernel for some strange
> > > reason doesn't find your router, even though "dump_pirq" obviously does..
> > > If there's something wrong with the checksumming for example..
> >
> > ..building now.
>
> Actually, try this patch first. It adds the PCI_DEVICE_ID_INTEL_82371MX
> router type, and also makes the PCI router search fall back more
> gracefully on the device it actually found if there is not an exact match
> on the "compatible router" entry...
>
> It should make Linux find and accept the chip you have. Knock wood.
>
>                 Linus
>
> --- v2.4.0-test10/linux/arch/i386/kernel/pci-irq.c      Tue Oct 31 12:42:26 2000
> +++ linux/arch/i386/kernel/pci-irq.c    Sat Nov 18 21:11:19 2000
> @@ -283,12 +297,19 @@
>         { "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371FB_0, pirq_piix_get, pirq_piix_set },
>         { "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371SB_0, pirq_piix_get, pirq_piix_set },
>         { "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_0, pirq_piix_get, pirq_piix_set },
> +       { "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371MX,   pirq_piix_get, pirq_piix_set },
>         { "PIIX", PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_0, pirq_piix_get, pirq_piix_set },
> +
>         { "ALI", PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533, pirq_ali_get, pirq_ali_set },
> +
>         { "VIA", PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_0, pirq_via_get, pirq_via_set },
>         { "VIA", PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C596, pirq_via_get, pirq_via_set },
>         { "VIA", PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686, pirq_via_get, pirq_via_set },
> +
>         { "OPTI", PCI_VENDOR_ID_OPTI, PCI_DEVICE_ID_OPTI_82C700, pirq_opti_get, pirq_opti_set },
> +
> +       { "NatSemi", PCI_VENDOR_ID_CYRIX, PCI_DEVICE_ID_CYRIX_5520, pirq_cyrix_get, pirq_cyrix_set },
> +
>         { "default", 0, 0, NULL, NULL }
>  };
>
> @@ -298,7 +319,6 @@
>  static void __init pirq_find_router(void)
>  {
>         struct irq_routing_table *rt = pirq_table;
> -       u16 rvendor, rdevice;
>         struct irq_router *r;
>
>  #ifdef CONFIG_PCI_BIOS
> @@ -308,32 +328,31 @@
>                 return;
>         }
>  #endif
> -       if (!(pirq_router_dev = pci_find_slot(rt->rtr_bus, rt->rtr_devfn))) {
> +       /* fall back to default router if nothing else found */
> +       pirq_router = pirq_routers + sizeof(pirq_routers) / sizeof(pirq_routers[0]) - 1;
> +
> +       pirq_router_dev = pci_find_slot(rt->rtr_bus, rt->rtr_devfn);
> +       if (!pirq_router_dev) {
>                 DBG("PCI: Interrupt router not found at %02x:%02x\n", rt->rtr_bus, rt->rtr_devfn);
> -               /* fall back to default router */
> -               pirq_router = pirq_routers + sizeof(pirq_routers) / sizeof(pirq_routers[0]) - 1;
>                 return;
>         }
> -       if (rt->rtr_vendor) {
> -               rvendor = rt->rtr_vendor;
> -               rdevice = rt->rtr_device;
> -       } else {
> -               /*
> -                * Several BIOSes forget to set the router type. In such cases, we
> -                * use chip vendor/device. This doesn't guarantee us semantics of
> -                * PIRQ values, but was found to work in practice and it's still
> -                * better than not trying.
> -                */
> -               DBG("PCI: Guessed interrupt router ID from %s\n", pirq_router_dev->slot_name);
> -               rvendor = pirq_router_dev->vendor;
> -               rdevice = pirq_router_dev->device;
> -       }
> -       for(r=pirq_routers; r->vendor; r++)
> -               if (r->vendor == rvendor && r->device == rdevice)
> +
> +       for(r=pirq_routers; r->vendor; r++) {
> +               /* Exact match against router table entry? Use it! */
> +               if (r->vendor == rt->rtr_vendor && r->device == rt->rtr_device) {
> +                       pirq_router = r;
>                         break;
> -       pirq_router = r;
> -       printk("PCI: Using IRQ router %s [%04x/%04x] at %s\n", r->name,
> -              rvendor, rdevice, pirq_router_dev->slot_name);
> +               }
> +               /* Match against router device entry? Use it as a fallback */
> +               if (r->vendor == pirq_router_dev->vendor && r->device == pirq_router_dev->device) {
> +                       pirq_router = r;
> +               }
> +       }
> +       printk("PCI: Using IRQ router %s [%04x/%04x] at %s\n",
> +               pirq_router->name,
> +               pirq_router_dev->vendor,
> +               pirq_router_dev->device,
> +               pirq_router_dev->slot_name);
>  }
>
>  static struct irq_info *pirq_get_info(struct pci_dev *dev, int pin)

--------------9177FA5BFF333A319F8F33DB
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------9177FA5BFF333A319F8F33DB--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
