Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263635AbUEHJFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263635AbUEHJFj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 05:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264197AbUEHJFi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 05:05:38 -0400
Received: from [61.135.145.20] ([61.135.145.20]:63516 "EHLO sohumx05.sohu.com")
	by vger.kernel.org with ESMTP id S263635AbUEHJF0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 05:05:26 -0400
Message-ID: <2512736.1084007124337.JavaMail.postfix@mx0.mail.sohu.com>
Date: Sat, 8 May 2004 17:05:24 +0800 (CST)
From: <dongzai007@sohu.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: vid&pid problems in usb_probe()
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Sohu Web Mail 2.0.13
X-SHIP: 218.107.149.1
X-Priority: 3
X-SHMOBILE: 0
X-SHBIND: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for replying,but I don't know what you mean,
USB descriptor data structure is defined in 
"/usr/include/linux/usb.h"

my kernel version is 2.4.18.


-----  Original Message  -----
From: Randy.Dunlap 
To: dongzai007@sohu.com 
Cc: linux-kernel@vger.kernel.org 
Subject: Re: vid&pid problems in usb_probe()
Sent: Sat May 08 12:45:54 CST 2004

> On Sat, 8 May 2004 11:48:44 +0800 (CST) <dongzai007@sohu.com> wrote:
> 
> | 
> | 
> | I am writting an usb driver.You know function usb_probe(...) is used to determine whether the usbdevices just pluged in is what the driver is for.
> 
> a.  Please learn to use the Enter/Return key around character position
> 70 (or before) on each line.
> 
> b.  what kernel version?   (*always*)
> 
> c.  You should ask this on the linux-usb-development mailing list:
> linux-usb-devel@lists.sf.net
> 
> 
> | The Vid and Pid of my usb device are 0x1111 and 0x0000 respectively.
> | 
> | the program is :
> | 
> | static void* usb_probe(struct usb_device *udev, unsigned int ifnum, const struct usb_device_id *id)
> | {
> |     ..............
> |     ..............
> |     
> |     printk("<1>Vid:%x
Pid:%x
",udev->descriptor.idVendor,udev->descriptor.idProduct);
> | 
> |     if ((udev->descriptor.idVendor!=0x1111)
> |          ||(udev->descriptor.idProduct!=0x0000)) return NULL;
> | 
> |     ..............
> | }
> | 
> | when I plug the device whose vid & pid is 0x1111 & 0x0000 respectively.
> | this Module displayed
> | 
> | 
> | Vid:0
> | Pid:201
> | 
> | usb.c ........ no active driver for this device;
> | 
> | and when I plug another device , I also got wrong vid & pid.
> | 
> | But when I wrote program as below:
> | 
> | __u16 tmp=0x1111;
> | printk("<1>%x",tmp);
> | 
> | it can print "1111" on the screen. That means my syntax is correct.
> | I mean, the problem may be at the data transfered into function usb_probe()
> | Maybe data transfered into function usb_probe() is wrong.
> | 
> | I wonder where is the problem, how can i solve.
> 
> Seeing more (or all) of your source code could help.
> I'm especially curious (suspicious) about your USB descriptor data
> structures.
> 
> --
> ~Randy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

