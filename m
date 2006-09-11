Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWIKPC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWIKPC7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 11:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751193AbWIKPC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 11:02:59 -0400
Received: from h155.mvista.com ([63.81.120.155]:53044 "EHLO imap.sh.mvista.com")
	by vger.kernel.org with ESMTP id S932249AbWIKPC5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 11:02:57 -0400
Message-ID: <45057B27.9020302@ru.mvista.com>
Date: Mon, 11 Sep 2006 19:05:11 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: What's in libata-dev.git
References: <20060911132250.GA5178@havoc.gtf.org>	 <45056627.7030202@ru.mvista.com> <450566A2.1090009@garzik.org>	 <450568F3.3020005@ru.mvista.com> <1157986974.23085.147.camel@localhost.localdomain> <45057651.8000404@garzik.org>
In-Reply-To: <45057651.8000404@garzik.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Jeff Garzik wrote:
>> Ar Llu, 2006-09-11 am 17:47 +0400, ysgrifennodd Sergei Shtylyov:

>>>     It's not likely I'll be able to try it. But I'm absolutely sure 
>>> that drive aborted the read commands with the sector count of 0 (i.e. 
>>> 256 actually). The exact model was IBM DHEA-34331.

>> Several people reported this problem when we tried 256 years ago in
>> drivers/ide. You might want to do 256 for SATA Jeff but please don't do
>> 256 for PATA. Reading specs is too hard for some people ;)

>> Some drives abort the xfer, some just choked.

> Where in drivers/ide is it limited to 255?

    Hm, indeed, it's 256 there...
    But the changelog in ide-probe.c suggests the were limited to 255 once 
upon a time. Also, hd.c still has this limit, and changelog talling why it was 
so...

WBR, Sergei
