Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269798AbTGKGNQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 02:13:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269803AbTGKGNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 02:13:16 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:43393 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S269798AbTGKGNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 02:13:14 -0400
From: imunity@softhome.net
To: linux-kernel@vger.kernel.org
Subject: USB-UHCI Fatal Error for all 2.5 kernels and 2.5.75 in RedHat v9.0 (fwd)
Date: Fri, 11 Jul 2003 00:27:56 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [12.249.189.237]
Message-ID: <courier.3F0E58EC.000047AD@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 


 ----------Forwarded message ----------
References: <courier.3F0E130B.000035DE@softhome.net>
           <20030711015029.GA15893@kroah.com>
In-Reply-To: <20030711015029.GA15893@kroah.com>
From: imunity@softhome.net
To: Greg KH <greg@kroah.com>
Subject: Re: USB-UHCI Fatal Error for all 2.5 kernels and 2.5.75 in RedHat 
v9.0
Date: Fri, 11 Jul 2003 00:01:30 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Sender: imunity@softhome.net
X-Originating-IP: [12.249.189.237] 

Greg KH writes: 

> On Thu, Jul 10, 2003 at 07:29:47PM -0600, imunity@softhome.net wrote:
>> 
>> For soem reason right after the boot of the 2.5 kernels right when the INIT 
>> starts the USB-UHCI fails for  the HID devices. 
> 
> Exactly what error are you getting in the kernel log?  
> 
> greg k-h
 

 

Could not find a Log specific for the INIT: 

Looked in /var/log 


I just carefully read the error and now figured out why its FATAL. 

It cannot find the usb-uhci.o module 

I looked in /lib/modules/kernel/drivers/usb and it is no where to be found. 

It is configured in the kernel I checked and double checked. 

I tried it as module and as monolithic and either way I get "FATAL" during 
the INIT: part of the bootup for usb. 

Why isn't the kernel source package configuring the usb-uhci module 
correctly? 

This is for all the kernels I have tested from 2.5.72 and up to 2.5.75. 


I figured out why I am getting the error with "devpts".  It is not supported 
in the 2.5 kernel's or I just cannot  find it. 

the UNIX TY98 /dev/pts.  I found it for the 2.4 kernels but not for the 2.5 
so that explains why I am getting the error mounting fs for pts. 


The Penguin logo is broken again for 2.5.75.  It was working for 2.5.74-mm2 
and mm3. 

As a matter of fact mm2 fixed the vesa issue and it was at that point I was 
able to get the penguin logo again, but stooped for 2.5.75. 

Weird how things get fixed then other things that worked get broken. 

