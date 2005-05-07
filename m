Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262755AbVEGWR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262755AbVEGWR4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 May 2005 18:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbVEGWRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 May 2005 18:17:55 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:123 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262755AbVEGWRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 May 2005 18:17:44 -0400
Message-ID: <427D3E7E.2020405@yahoo.com>
Date: Sat, 07 May 2005 18:17:34 -0400
From: "J. Scott Kasten" <jscottkasten@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; IRIX64 IP30; en-US; rv:1.4.1) Gecko/20040105
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: rajat swarup <rajats@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: sending ICMP messages in kernel module
References: <7d04ec5605050622006f3ad56c@mail.gmail.com>
In-Reply-To: <7d04ec5605050622006f3ad56c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


rajat swarup wrote:

>Hi,
>I have placed a netfilter hook in which I grab the packets in the
>pre-routing stage.
>I need to send ICMP messages in response to certain messages in this hook.
>I looked at alloc_skb(), skb_reserve() and skb_put() functions but it
>is still not clear to me as to how to construct the packets using
>these methods.
>Since I am getting the packets in the Pre-routing stage should I
>explicitly construct the MAC header, IP header & data & ICMP message?
>Also, I'll need to calculate the checksum to be transmitted in the
>ICMP packet...which method could I use to do that?
>  
>
Hello,

I had a similar problem once.  In the icmp.c file, look at how the ping 
echo reply works.  That is as close to a tutorial as you will find in 
the code.  I think you might find it strait forward from there.

-Scott-

