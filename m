Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbWAWWzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWAWWzg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 17:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964971AbWAWWzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 17:55:36 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:15074 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S964972AbWAWWzf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 17:55:35 -0500
Message-ID: <43D55EC9.10605@comcast.net>
Date: Mon, 23 Jan 2006 15:55:05 -0700
From: WSteffen <wsteffen@comcast.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: IRQ problems??
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am working with an HP Pavilion a1210n the mother board is
an ASUS A8AE-LE, which has an ATI IXP SB440 and a Realtek
ethernet controller. The processor is an AMD Athlon 64 3500+.
The USB controllers will not function unless ACPI is enabled
in the kernel.
If ACPI is enabled in the kernel the realtek ethernet is not
usable. If I do a ping to a working device on the same net,
I can see ARP requests going out and replies coming back.
However I get "host unreachable" error messages.
When looking at the interrupts in each case it appears to me
that there is an IRQ assignment problem. (my guess is the
Realtek driver) or is there something I am doing wrong??
Below are the contents of /proc/interrupts:

With ACPI set:
          CPU0
   0:     135197          XT-PIC  timer
   1:        315          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   5:          8          XT-PIC  eth1
   7:          0          XT-PIC  parport0
   9:          3          XT-PIC  acpi
  11:        208          XT-PIC  libata, ehci_hcd:usb1, ohci_hcd:usb2, 
ohci_hcd:usb3, eth0
  12:       5202          XT-PIC  i8042
  15:       4451          XT-PIC  ide1
NMI:          0
ERR:          0

  	CPU0
   0:      37706          XT-PIC  timer
   1:        225          XT-PIC  i8042
   2:          0          XT-PIC  cascade
   5:          8          XT-PIC  eth1
  10:          6          XT-PIC  eth0
  11:          2          XT-PIC  libata
  12:        110          XT-PIC  i8042
  15:       4398          XT-PIC  ide1
NMI:          0
ERR:          0

With ACPI not set:

If there is something I am doing wrong, please let me know!!

Thanks
Warren Steffen
wsteffen@comcast.net
