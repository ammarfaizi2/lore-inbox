Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266736AbSLJKgp>; Tue, 10 Dec 2002 05:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266638AbSLJKgp>; Tue, 10 Dec 2002 05:36:45 -0500
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:43226 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S265469AbSLJKgn>; Tue, 10 Dec 2002 05:36:43 -0500
Message-ID: <3DF5C492.1070103@drugphish.ch>
Date: Tue, 10 Dec 2002 11:40:18 +0100
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Willy Tarreau <willy@w.ods.org>, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: hidden interface (ARP) 2.4.20
References: <A6B0BFA3B496A24488661CC25B9A0EFA333DEF@himl07.hickam.pacaf.ds.af.mil>	<1039124530.18881.0.camel@rth.ninka.net>	<20021205140349.A5998@ns1.theoesters.com>	<3DEFD845.1000600@drugphish.ch>	<20021205154822.A6762@ns1.theoesters.com>	<20021208170135.GA354@alpha.home.local> <20021209120814.2eaaef29.skraw@ithnet.com>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

>>Why not ?
>>I've often been doing this to check the reliability of the network layer of
>>kernels that I distribute. I often use Tux for this, because it can easily
>>sustain 10k hits/s during months.
>  
> This is unfortunately not sufficient, not even close to. If you really want to
> have a good idea what is going on you should as well check out what is happening
> with packet sizes a lot smaller than 1500 (normal mtu). Check data rate an
> packet loss with packet sizes around 80 bytes or so to get an idea what bothers
> us :-)

But this doesn't have anything to do with the hidden patch! It can be 
multiple things:

o missing TCP segment offload support
o inefficient zerocopy DMA support
o IRQ routing problems
o wrong QoS settings

Could you please be more specific on what exactly you're trying to 
achieve? Do you want to load balance an application whose average 
package size is 80 bytes? How many sustained connections per seconds do 
you have?

Best regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

