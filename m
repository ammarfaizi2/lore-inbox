Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266042AbUALEEW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 23:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266043AbUALEEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 23:04:22 -0500
Received: from mtaw6.prodigy.net ([64.164.98.56]:54708 "EHLO mtaw6.prodigy.net")
	by vger.kernel.org with ESMTP id S266042AbUALEEV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 23:04:21 -0500
Message-ID: <40021E8E.3010709@pacbell.net>
Date: Sun, 11 Jan 2004 20:11:58 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       USB Developers <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: USB hangs
References: <1073779636.17720.3.camel@dhcp23.swansea.linux.org.uk> <20040111002304.GE16484@one-eyed-alien.net> <1073788437.17793.0.camel@dhcp23.swansea.linux.org.uk> <4001DB52.7030908@pacbell.net> <20040111233104.GF23039@one-eyed-alien.net>
In-Reply-To: <20040111233104.GF23039@one-eyed-alien.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>>	 Plus I'd
>>>argue PF_MEMALLOC is a better solution anyway.
>>
>>It certainly seems like a more comprehensive fix for that
>>particular class of problems!  :)
> 
> 
> Is it really more comprehensive?  As I see it, it will only affect code
> executed in the context of the usb-storage thread.  But, what about code
> which is invoked in tasklets or other contexts?

Isn't it true that only that thread is allowed to
submit usb-storage i/o requests?

- Dave


