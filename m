Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263876AbTLEF4l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 00:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263880AbTLEF4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 00:56:41 -0500
Received: from mail.netzentry.com ([157.22.10.66]:41999 "EHLO netzentry.com")
	by vger.kernel.org with ESMTP id S263876AbTLEF4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 00:56:37 -0500
Message-ID: <3FD01E12.4040801@netzentry.com>
Date: Thu, 04 Dec 2003 21:56:34 -0800
From: "b@netzentry.com" <b@netzentry.com>
Reply-To: b@netzentry.com
Organization: b@netzentry.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: recbo@nishanet.com, linux-kernel@vger.kernel.org
Subject: RE: NForce2 pseudoscience stability testing (2.6.0-test11) - IRQ
 flood related ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have almost everything disabled and the error occurs.

USB1 OFF
USB2 OFF
FireWire OFF
SATA - Jumpered OFF
AUDIO OFF
NVIDIA LAN OFF.

lspci
00:00.0 Host bridge: nVidia Corporation nForce2 AGP (different
version?) (rev c1)
00:00.1 RAM memory: nVidia Corporation nForce2 Memory Controller 1
(rev c1)
00:00.2 RAM memory: nVidia Corporation nForce2 Memory Controller 4
(rev c1)
00:00.3 RAM memory: nVidia Corporation nForce2 Memory Controller 3
(rev c1)
00:00.4 RAM memory: nVidia Corporation nForce2 Memory Controller 2
(rev c1)
00:00.5 RAM memory: nVidia Corporation nForce2 Memory Controller 5
(rev c1)
00:01.0 ISA bridge: nVidia Corporation nForce2 ISA Bridge (rev a4)
00:01.1 SMBus: nVidia Corporation nForce2 SMBus (MCP) (rev a2)
00:08.0 PCI bridge: nVidia Corporation nForce2 External PCI Bridge
(rev a3)
00:09.0 IDE interface: nVidia Corporation nForce2 IDE (rev a2)
00:0c.0 PCI bridge: nVidia Corporation nForce2 PCI Bridge (rev a3)
00:1e.0 PCI bridge: nVidia Corporation nForce2 AGP (rev c1)
01:07.0 Ethernet controller: Digital Equipment Corporation Farallon
PN9000SX (rev 01)
01:08.0 Ethernet controller: Digital Equipment Corporation Farallon
PN9000SX (rev 01)
02:01.0 Ethernet controller: 3Com Corporation 3C920B-EMB Integrated
Fast Ethernet Controller (rev 40)
03:00.0 VGA compatible controller: nVidia Corporation NV18
[GeForce4 MX 440 AGP 8x] (rev a2)

Thats it. And this think locks anytime APIC is enabled. Its just a
matter of time.


Bob wrote
 >(2.6.0-test11) - IRQ flood related ?
 >
 >
 >Do you have onboard ethernet enabled with nforce2
 >mboard? I am fine with pre-emptive kernel but have
 >to disable onboard ethernet in cmos setup or I see
 >"Disabling IRQ7" and problems develop.
 >
 >-Bob
 >
 >Craig Bradney wrote:
 >
 >>Prakash,
 >>
 >>try it without preempt.. just to see. As soon as I removed it
 >today the
 >>crashes went away (for 5 hours).. PC is now up for 2.5 hours and I'm
 >>waiting to see if it will be 5 hrs or 5 days this time around :)
 >>
 >>Craig
 >>
 >>On Fri, 2003-12-05 at 00:14, Prakash K. Cheemplavam wrote:
 >>
 >>
 >>>Jesse Allen wrote:
 >>>
 >>>
 >>>>On Thu, Dec 04, 2003 at 09:02:08PM +0100,

 >>>>
 >>>>
 >>>>
 >>>>>Hello,
 >>>>>
 >>>>>Along with the lockups already described here, I've noticed an
 >>>>>unidentified source of interrupts on IRQ7.
 >>>>>
 >>>>>
 >>>>...
 >>>>
 >>>>
 >>>>
 >>>>>I wonder if people experiencing lockup problems also have these
 >>>>>noise interrupts,
 >>>>>
 >>>>>
 >>>>I just took a look at this, by setting up parport_pc, and
 >yes I get noise.
 >>>>
 >>>>This was my first sample with a kernel with APIC:
 >>>>  7:      29230    IO-APIC-edge  parport0
 >>>>
 >>>>
 >>>I just did an experiment with a very light kernel, nearly nothing
 >>>compiled inside, except apic acpi, preempt and needed stuff plus
 >>>scsi+libata and no ide. IRQ 7 was not present and every
 >device had its
 >>>own irq. Nevertheless system locked up at second hdparm run...
 >>>
 >>>Prakash
 >>>
 >>>
 >>
 >
 >


