Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbVK3U3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbVK3U3c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 15:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbVK3U3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 15:29:31 -0500
Received: from web36914.mail.mud.yahoo.com ([209.191.85.82]:22975 "HELO
	web36914.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750720AbVK3U3b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 15:29:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Tr955pD4cNo3C+hoj/TQjEygJfHqxXvEShlGfYGMs7SEsLS5YlZaa9AQYbNNTdYBt0Djtjd0z7PEJ/+v/fKuKO3bb7JqlxIoQ5UBvL6A6aKpGAIwynsgSBwrbdSBBfWeGGIcps3J07sVmFwyCnPBR/tKF6+e+8vO5+stCVH1SyQ=  ;
Message-ID: <20051130202930.67776.qmail@web36914.mail.mud.yahoo.com>
Date: Wed, 30 Nov 2005 20:29:30 +0000 (GMT)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: [PATCH 2.6-git] SPI core refresh
To: Vitaly Wool <vwool@ru.mvista.com>, linux-kernel@vger.kernel.org
Cc: david-b@pacbell.net, dpervushin@gmail.com, akpm@osdl.org, greg@kroah.com,
       basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
In-Reply-To: <20051130195053.713ea9ef.vwool@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Vitaly Wool <vwool@ru.mvista.com> wrote:

> Greetings,
> 
> This is an updated version of SPI framework developed by Dmitry Pervushin and Vitaly Wool.
> 
> The main changes are:
> 
> - Matching rmk's 2.6.14-git5+ changes for device_driver suspend and resume calls
> - The character device interface was reworked
> 
> I still think that we need to continue converging with David Brownell's core, despite some
> misalignments happening in the email exchange :). Although it's not yet done in our core, I plan
> to move to 
> - using chained SPI messages as David does
> - maybe rework the SPI device interface more taking David's one as a reference
> 
> However, there also are some advantages of our core compared to David's I'd like to mention
> 
> - it can be compiled as a module
So can David's. You can use BIOS tables in which case you must compile the SPI core into the
kernel but you can also use spi_new_device which allows the SPI core to be built as a module (and
is how I am using it).

> - it is DMA-safe
To my understanding David's core is DMA-safe. Yes there is a question mark over one of the helper
functions, but the _main_ functions _are_ DMA-safe.

> - it is priority inversion-free
> - it can gain more performance with multiple controllers
Sorry I'm not sure what you mean here.

> - it's more adapted for use in real-time environments
> - it's not so lightweight, but it leaves less effort for the bus driver developer.

But also less flexibility. A core layer shouldn't _force_ a policy
on a bus driver. I am currently developing an adapter driver for David's system and I wouldn't say
that the core is making me do things I think the core should do. Please could you provide examples
of where you think Davids SPI core requires 'effort'.

Mark



	
	
		
___________________________________________________________ 
Yahoo! Messenger - NEW crystal clear PC to PC calling worldwide with voicemail http://uk.messenger.yahoo.com
