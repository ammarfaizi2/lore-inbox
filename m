Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263991AbTBETvB>; Wed, 5 Feb 2003 14:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264628AbTBETvB>; Wed, 5 Feb 2003 14:51:01 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:1945 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP
	id <S263991AbTBETvA>; Wed, 5 Feb 2003 14:51:00 -0500
Message-ID: <3E416D45.8090503@bogonomicon.net>
Date: Wed, 05 Feb 2003 14:00:05 -0600
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>, rossb@google.com,
       alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre4: PDC ide driver problems with shared interrupts
References: <20030202161837.010bed14.skraw@ithnet.com>	<3E3D4C08.2030300@pobox.com>	<20030202185205.261a45ce.skraw@ithnet.com>	<3E3D6367.9090907@pobox.com>	<20030205104845.17a0553c.skraw@ithnet.com>	<1044443761.685.44.camel@zion.wanadoo.fr>	<3E414243.4090303@google.com>	<1044465151.685.149.camel@zion.wanadoo.fr>	<3E4147A0.4050709@google.com>	<1044466495.684.153.camel@zion.wanadoo.fr> <20030205183808.3a2fa115.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ok, yet another small brick in the wall: this mb has 64bit/66MHz PCI slots. PDC
> is only 32bit/33MHz PCI. So it may well be that others are in fact _able_ to
> produce a damn lot more data/interrupts than the PDC. I am pretty astonished by
> the number of interrupts created by the 3com tg3 cards anyways...

On my box one of the devices sharing the interrupt with the disk
is the display, the USB is quiet with no devices connected.  I am 
running 2.4.21-pre4-ac2.  I'd have redistributed interrupts but the 
motherboard dosen't allow me to specifically set them and APIC isn't 
supposed to work on the nForce2 yet.

cat /proc/interrupts
            CPU0
   0:     273068          XT-PIC  timer
   1:       5547          XT-PIC  keyboard
   2:          0          XT-PIC  cascade
   5:     122188          XT-PIC  eth0
  10:     641526          XT-PIC  ide2, ide3, usb-ohci, nvidia
  11:          0          XT-PIC  NVIDIA nForce Audio, usb-ohci
  12:      78237          XT-PIC  PS/2 Mouse
  14:     109475          XT-PIC  ide0
  15:     114178          XT-PIC  ide1
NMI:          0
LOC:     273027
ERR:      18344
MIS:          0

- Bryan

