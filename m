Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267304AbUJGPBP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267304AbUJGPBP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 11:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266896AbUJGPBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 11:01:15 -0400
Received: from chaos.analogic.com ([204.178.40.224]:15744 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266273AbUJGO7u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 10:59:50 -0400
Date: Thu, 7 Oct 2004 10:57:25 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Martijn Sipkema <msipkema@sipkema-digital.com>, Paul Jakma <paul@clubi.ie>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       "David S. Miller" <davem@davemloft.net>, joris@eljakim.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: UDP recvmsg blocks after select(), 2.6 bug?
In-Reply-To: <1097156929.31753.47.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0410071055300.3694@chaos.analogic.com>
References: <Pine.LNX.4.58.0410061616420.22221@eljakim.netsystem.nl> 
 <20041006080104.76f862e6.davem@davemloft.net>  <Pine.LNX.4.61.0410061110260.6661@chaos.analogic.com>
  <20041006082145.7b765385.davem@davemloft.net> 
 <Pine.LNX.4.61.0410061124110.31091@chaos.analogic.com> 
 <Pine.LNX.4.61.0410070212340.5739@hibernia.jakma.org>  <4164EBF1.3000802@nortelnetworks.com>
  <Pine.LNX.4.61.0410071244150.304@hibernia.jakma.org> 
 <001601c4ac72$19932760$161b14ac@boromir>  <Pine.LNX.4.61.0410071346040.304@hibernia.jakma.org>
  <001c01c4ac76$fb9fd190$161b14ac@boromir> <1097156929.31753.47.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2004, Alan Cox wrote:

> On Iau, 2004-10-07 at 15:07, Martijn Sipkema wrote:
>>> Much can change between the select() and recvmsg - things outside of
>>> kernel control too, and it's long been known.
>>
>> There is no change; the current implementation just checks the validity of
>> the data in the recvmsg() call and not during select().
>
> The accept one is documented by Stevens and well known. In the UDP case
> currently we could get precise behaviour - by halving performance of UDP
> applications like video streaming. We probably don't want to  because we
> can respond intelligently to OOM situations by freeing the queue if we
> don't enforce such a silly rule.
>

Well if you accept(pun_intended) what Stevens says, then check his
web-site on what he teaches about select() and sockets. His demo
code certainly requires that select() not fail.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.5-1.358-noreg on an i686 machine (5537.79 BogoMips).
             Note 96.31% of all statistics are fiction.

