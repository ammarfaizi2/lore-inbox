Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267372AbTBFRdL>; Thu, 6 Feb 2003 12:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267375AbTBFRdL>; Thu, 6 Feb 2003 12:33:11 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:58584 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S267372AbTBFRdK>; Thu, 6 Feb 2003 12:33:10 -0500
Message-ID: <3E429E5C.8060503@google.com>
Date: Thu, 06 Feb 2003 09:41:48 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PATCH: add framework for ndelay (nanoseconds)
References: <200302040533.h145Xqq19457@hera.kernel.org>	 <Pine.GSO.4.21.0302051533320.16681-100000@vervain.sonytel.be>	 <20030206174944.A17905@jurassic.park.msu.ru> <1044546783.10374.4.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>Why waste 500nS every IDE command as opposed to doing the job right ? The initial
>ndelay() is a quick implementation. If you don't like it implement a better one,
>if your box isnt fast implement it as udelay.
>  
>
The delay should be made controller specific.  On most controllers the 
reading of the alt status we need to do to flush the write command to 
the drive will also cause enough of a delay so that the ndelay isn't 
needed at all.  For example the on the Promise 20265 and 20267 the alt 
status read will always take at least 600ns.

    Ross

