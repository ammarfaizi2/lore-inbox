Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265136AbTFYWnK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 18:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbTFYWnK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 18:43:10 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:42244 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S265136AbTFYWnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 18:43:08 -0400
Message-ID: <3EFA2939.2060005@techsource.com>
Date: Wed, 25 Jun 2003 18:59:05 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Edward Tandi <ed@efix.biz>
CC: joe briggs <jbriggs@briggsmedia.com>,
       Artur Jasowicz <kernel@mousebusiness.com>,
       Brian Jackson <brian@brianandsara.net>,
       Bart SCHELSTRAETE <Bart.SCHELSTRAETE@dhl.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: AMD MP, SMP, Tyan 2466
References: <BB1F47F5.17533%kernel@mousebusiness.com>	 <200306251501.14207.jbriggs@briggsmedia.com> <1056567378.31260.9.camel@wires.home.biz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Edward Tandi wrote:

> 
> 
> Yes, for SMP mode you absolutely need to use 'registered' RAM. Normal
> PC2100 ram will work OK with one processor but quickly fails with two (I
> had the same problems). Apparently, DDR RAM uses one clock edge to
> transfer in one direction and the opposite edge to transfer back again
> so the registers do synchronisation between one processor writing to the
> same location that the other one reads from. That's how it was explained
> to me anyway.
> 


DDR memory works very much like single data rate, except that data is 
transferred (in whichever direction it's going) on both edges of the 
clock, thus doubling the transfer rate.  The memory does not switch 
between reading and writing as you describe it.

I believe registering is for reliability.  Data is transferred one clock 
cycle later but reduces signal loading.

