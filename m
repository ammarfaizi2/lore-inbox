Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262789AbTCDWnn>; Tue, 4 Mar 2003 17:43:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262812AbTCDWnn>; Tue, 4 Mar 2003 17:43:43 -0500
Received: from h008.c015.snv.cp.net ([209.228.35.123]:39597 "HELO
	c015.snv.cp.net") by vger.kernel.org with SMTP id <S262789AbTCDWnm>;
	Tue, 4 Mar 2003 17:43:42 -0500
X-Sent: 4 Mar 2003 22:54:10 GMT
Message-ID: <3E652EF7.7010405@lemur.sytes.net>
Date: Tue, 04 Mar 2003 17:55:51 -0500
From: Mathias Kretschmer <mathias@lemur.sytes.net>
Reply-To: mathias.kretschmer@verizon.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20020924
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE DVD reading & error handling
References: <3E64EE6A.90208@lemur.sytes.net> <1046818748.12226.21.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think its perfectly doable to set the maximum retries per
> device. Have a look at the current ide_error() and the error: handler
> in the relevant ide drivers (notably ide-cd).
> 
> 
>>I wonder if it would be possible to tune the IDE layer by i.e.
>>reducing the number of retries and disabling the controller reset, etc.
> 
> 
> A lot of the time you have to go through the controller reset. However 
> cutting the retries down and having good readahead management on the
> I/O thread ought to still cope with that.

that's what I'm hoping for :)

Would it also be possible/make sense to never switch from DMA to PIO 
mode since those DVD read errors are most likely not a DMA problem ?


