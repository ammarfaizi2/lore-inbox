Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285135AbSAAVtN>; Tue, 1 Jan 2002 16:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285574AbSAAVsy>; Tue, 1 Jan 2002 16:48:54 -0500
Received: from relais.videotron.ca ([24.201.245.36]:27068 "EHLO
	VL-MS-MR004.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id <S285135AbSAAVsm>; Tue, 1 Jan 2002 16:48:42 -0500
Message-ID: <3C322EB9.6080300@videotron.ca>
Date: Tue, 01 Jan 2002 16:48:41 -0500
From: Roger Leblanc <r_leblanc@videotron.ca>
Organization: General DataComm
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Deadlock in kernel on USB shutdown
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just compiled version 2.4.17 of the Linux kernel for my Pentium III. 
It is compiled with modular USB support so I can run my USB scanner (an 
Epson Perfection 1200U).

The scanner works fine but the system freeses when I shut it down. I 
investigated a bit and found that in the file:
<kernel_root>/drivers/usb/usb.c
in function:
usb_disconnect(struct usb_device **pdev)

there is a call to function:
usbdevfs_remove_device(dev)
at line 2423.

That is the exact point where it freeses. If I comment out that line, 
everything goes fine. I know! This is not the proper way to fix it! But 
at least, it fixes my problem. Since I'm not a kernel expert, I will 
leave it to you to find the right way to fix it.

If you want me to try something or to give you more info, do not 
hesitate to contact me.

Thanks

Roger


