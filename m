Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314468AbSEFPIo>; Mon, 6 May 2002 11:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314490AbSEFPIn>; Mon, 6 May 2002 11:08:43 -0400
Received: from mercury.lss.emc.com ([168.159.40.77]:32522 "EHLO
	mercury.lss.emc.com") by vger.kernel.org with ESMTP
	id <S314468AbSEFPIn>; Mon, 6 May 2002 11:08:43 -0400
Message-ID: <FA2F59D0E55B4B4892EA076FF8704F553D1A3A@srgraham.eng.emc.com>
From: "chen, xiangping" <chen_xiangping@emc.com>
To: "'Steve Whitehouse'" <Steve@ChyGwyn.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Kernel deadlock using nbd over acenic driver.
Date: Mon, 6 May 2002 11:05:52 -0400 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am using 2.4.16 with xfs patch from SGI. It may not be the acenic
driver problem, I can reproduce the deadlock in a 100 base-T network
using eepro100 driver. Closing the server did not release the deadlock.
What else can I try?


-----Original Message-----
From: Steven Whitehouse [mailto:steve@gw.chygwyn.com]
Sent: Monday, May 06, 2002 4:46 AM
To: chen, xiangping
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel deadlock using nbd over acenic driver.


Hi,

What kernel version are you using ? I suspect that its not the ethernet
driver causing this deadlock. Am I right in thinking that if you kill the
nbd server process that the hanging process is released ?

Steve.

> 
> Hi,
> 
> I encounter a deadlock situation when using nbd device over gigabit
> ethernet. The network card is 3c 985 giga card using acenic driver. When
the
> network has some significant back ground traffic, even making a ext2 file
> system can not succeed. When the deadlock happens, the nbd client daemon
> just stuck in tcp_recvmsg() without receiving any data, and the sender
> threads continue to send out requests until the whole system hangs. Even I
> set the nbd client daemon SNDTIMEO, the nbd client daemon could not exit
> from tcp_recvmsg(). 
> 
> Is there any known problem with the acenic driver? How can I identify it
is
> a problem of the NIC driver, or somewhere else?
> 
> Thanks for help!
> 
> 
> Xiangping Chen 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
