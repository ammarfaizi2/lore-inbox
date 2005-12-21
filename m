Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbVLUNi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbVLUNi1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 08:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbVLUNi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 08:38:27 -0500
Received: from gw1.cosmosbay.com ([62.23.185.226]:55019 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S932413AbVLUNi0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 08:38:26 -0500
Message-ID: <43A95ABF.1030309@cosmosbay.com>
Date: Wed, 21 Dec 2005 14:38:07 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Folkert van Heusden <folkert@vanheusden.com>
CC: Ed Tomlinson <edt@aei.ca>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull
 on	x86_64 machines ?
References: <7vbqzadgmt.fsf@assigned-by-dhcp.cox.net>	<43A91C57.20102@cosmosbay.com> <200512210744.52559.edt@aei.ca> <20051221132046.GJ27831@vanheusden.com>
In-Reply-To: <20051221132046.GJ27831@vanheusden.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Wed, 21 Dec 2005 14:38:07 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folkert van Heusden a écrit :

> 
> 
> size-131072            0      0 131072
> size-65536             0      0  65536
> size-32768            20     20  32768
> size-16384             8      9  16384
> size-8192             37     38   8192
> size-4096            269    269   4096
> size-2048            793    910   2048
> size-1024            564    608   1024
> size-512             702    856    512
> size-256            1485   4005    256
> size-128            1209   1350    128
> size-64             2858   3363     64
> size-32             1538   2714     64
> Intel(R) Xeon(TM) MP CPU 3.00GHz
> address sizes   : 40 bits physical, 48 bits virtual
> 
> 
> Folkert van Heusden

Hi Folkert

Your results are interesting : size-32 seems to use objects of size 64 !

 > size-32             1538   2714     64 <<HERE>>

So I guess that size-32 cache could be avoided at least for EMT (I take you 
run a 64 bits kernel ?)

Eric
