Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281271AbRKPKT4>; Fri, 16 Nov 2001 05:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281272AbRKPKTh>; Fri, 16 Nov 2001 05:19:37 -0500
Received: from gw.chygwyn.com ([62.172.158.50]:50956 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S281271AbRKPKT0>;
	Fri, 16 Nov 2001 05:19:26 -0500
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200111161016.KAA14485@gw.chygwyn.com>
Subject: Re: The memory usage of the network block device
To: chen_xiangping@emc.com (chen, xiangping)
Date: Fri, 16 Nov 2001 10:16:18 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <FA2F59D0E55B4B4892EA076FF8704F553D188D@srgraham.eng.emc.com> from "chen, xiangping" at Nov 15, 2001 11:20:54 PM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

