Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315445AbSGEGQ2>; Fri, 5 Jul 2002 02:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315454AbSGEGQ1>; Fri, 5 Jul 2002 02:16:27 -0400
Received: from iproxy2.ericsson.dk ([213.159.160.69]:49288 "EHLO
	iproxy2.ericsson.dk") by vger.kernel.org with ESMTP
	id <S315445AbSGEGQZ>; Fri, 5 Jul 2002 02:16:25 -0400
Message-ID: <3D253A46.6050805@fabbione.net>
Date: Fri, 05 Jul 2002 08:18:46 +0200
From: Fabio Massimo Di Nitto <fabbione@fabbione.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
X-Accept-Language: en
MIME-Version: 1.0
To: Jussi Laako <jussi.laako@kolumbus.fi>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [FREEZE] 2.4.19-pre10 + Promise ATA100 tx2 ver 2.20 (also with
  Ultra133-TX2)
References: <3D14C06F.6010906@fabbione.net> <3D24A475.9CD70BE0@kolumbus.fi>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jussi Laako wrote:

>Fabio Massimo Di Nitto wrote:
>  
>
>>The freeze is reproducible both with 2.4.19-pre10 and 2.4.18.
>>    
>>
>
>I have lockups when updatedb is running using ide-2.4.19-p7.all.convert.10
>driver. Controller is Ultra133-TX2 (PDC20269) and mobo is ASUS A7M266
>(AMD761 northbridge).
>
>Memory has been checked to be OK. (48 hours of memtest86 3.0)
>
>
>	- Jussi Laako
>
>  
>
Hi Jussi,
        I found out that the problem was not the Promise controller
but a bug in the ALI chipset. Disabling the specific driver for that
chipset (and DMA as well :/ ) gives me atleast the possibility to work.
The bug for the ALI was discussed in another thread.

What makes me worried now is that 2/3 people are reporting a similar
problem but using different chipsets. Can be a problem located somewhere
else???? Dunno..... just a guess.


Fabio


