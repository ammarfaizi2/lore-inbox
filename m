Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129033AbQKIBOD>; Wed, 8 Nov 2000 20:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129044AbQKIBNy>; Wed, 8 Nov 2000 20:13:54 -0500
Received: from deliverator.sgi.com ([204.94.214.10]:27505 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S129033AbQKIBNp>; Wed, 8 Nov 2000 20:13:45 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: David Ford <david@linux.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [bug] usb-uhci locks up on boot half the time 
In-Reply-To: Your message of "Wed, 08 Nov 2000 16:35:36 -0800."
             <3A09F158.910C925@linux.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 Nov 2000 12:12:54 +1100
Message-ID: <2446.973732374@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Nov 2000 16:35:36 -0800, 
David Ford <david@linux.com> wrote:
>Ok, in test10, for every 2 out of 5 boots, this particular workstation
>locks up hard as it reaches the following:
>
>usb.c: registered new driver usbdevfs
>usb.c: registered new driver hub
>usb-uhci.c: $Revision: 1.242 $ time 15:53:47 Nov 8 2000
>usb-uhci.c: High bandwidth mode enabled
>usb-uhci.c: USB UHCI at I/O 0xb400, IRQ 9
>usb-uhci.c: Detected 2 ports
><locks here, hard reset required>

Apply the kernel debugger patch[*], select "APIC and IO-APIC support on
uniprocessors" then "NMI watchdog active for uniprocessors".  Compile,
install, reboot.  When the machine hangs, NMI should drop into kdb
after 5 seconds, 'bt' gives a backtrace.

ftp://oss.sgi.com/projects/kdb/download/ix86/kdb-v1.5-2.4.0-test10.gz

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
