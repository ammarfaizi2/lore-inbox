Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311564AbSEFJF6>; Mon, 6 May 2002 05:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314082AbSEFJF5>; Mon, 6 May 2002 05:05:57 -0400
Received: from gw.chygwyn.com ([62.172.158.50]:17924 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id <S311564AbSEFJFz>;
	Mon, 6 May 2002 05:05:55 -0400
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200205060845.JAA07094@gw.chygwyn.com>
Subject: Re: Kernel deadlock using nbd over acenic driver.
To: chen_xiangping@emc.com (chen, xiangping)
Date: Mon, 6 May 2002 09:45:49 +0100 (BST)
Cc: linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <FA2F59D0E55B4B4892EA076FF8704F553D1A37@srgraham.eng.emc.com> from "chen, xiangping" at May 05, 2002 10:26:57 PM
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

What kernel version are you using ? I suspect that its not the ethernet
driver causing this deadlock. Am I right in thinking that if you kill the
nbd server process that the hanging process is released ?

Steve.

> 
> Hi,
> 
> I encounter a deadlock situation when using nbd device over gigabit
> ethernet. The network card is 3c 985 giga card using acenic driver. When the
> network has some significant back ground traffic, even making a ext2 file
> system can not succeed. When the deadlock happens, the nbd client daemon
> just stuck in tcp_recvmsg() without receiving any data, and the sender
> threads continue to send out requests until the whole system hangs. Even I
> set the nbd client daemon SNDTIMEO, the nbd client daemon could not exit
> from tcp_recvmsg(). 
> 
> Is there any known problem with the acenic driver? How can I identify it is
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

