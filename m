Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281435AbRKPOmS>; Fri, 16 Nov 2001 09:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281433AbRKPOl7>; Fri, 16 Nov 2001 09:41:59 -0500
Received: from mercury.lss.emc.com ([168.159.40.77]:60421 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S281435AbRKPOlv>; Fri, 16 Nov 2001 09:41:51 -0500
Message-ID: <FA2F59D0E55B4B4892EA076FF8704F553D188E@srgraham.eng.emc.com>
From: "chen, xiangping" <chen_xiangping@emc.com>
To: "'Steve Whitehouse'" <Steve@ChyGwyn.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: The memory usage of the network block device
Date: Fri, 16 Nov 2001 09:41:46 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Steve

Thanks for the quick reply. I have tried a couple of 2.4.x kernel 
version, got the same result. I did not tune the /proc/sys/net/ipv4/tcp*mem,
so it should be the default value. Which value you recommend? The memory
size in the driver machine is 256M, I run into problem when do a bonnie 
test of 200M file size. I run nbd on two separate machines, so it should
not be a localhost deadlock problem.


Thanks,

Xiangping

-----Original Message-----
From: Steven Whitehouse [mailto:steve@gw.chygwyn.com]
Sent: Friday, November 16, 2001 5:16 AM
To: chen, xiangping
Cc: linux-kernel@vger.kernel.org
Subject: Re: The memory usage of the network block device


Hi,

I'm on holiday this week, so apologies in advance if my replies are not
as prompt as they would otherwise be....

Which kernel version are you using ? What are your settings in the
/proc/sys/net/ipv4/tcp_*mem files or did you just use the default
values ? Did you run the nbd server on the same machine as the client ?
How much memory do you have in the machine that you are testing with ?

Its a little while since I looked at nbd in detail, so if you can send me
enough info to reproduce your set up, then I'll try and have a go in the
next few days,

Steve.

> 
> Hi, 
> 
> I am trying to use the network block device in the Linux kernel.
> 
> The nbd works good in light io load, but during intensive io load
> testing, it seems that it fails to release the memory fast enough.
> Eventually the driver blocks at tcp_sendmsg, and waits for the
> memory that seems never come. A simple bonnie test to create
> a file about the size of the host memory shows the problem.
> 
> Is there any way to free up memory more quickly? or why the
> network memory is held without being released?
> 
> Thanks,
> 
> Xiangping
> 
