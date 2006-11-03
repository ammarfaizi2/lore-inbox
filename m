Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751010AbWKCL4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010AbWKCL4i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 06:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751151AbWKCL4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 06:56:38 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:41680 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751010AbWKCL4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 06:56:37 -0500
Date: Fri, 3 Nov 2006 12:56:36 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
In-Reply-To: <20061103101901.GA11947@wohnheim.fh-wedel.de>
Message-ID: <Pine.LNX.4.64.0611031252430.17174@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
 <20061102235920.GA886@wohnheim.fh-wedel.de> <Pine.LNX.4.64.0611030217570.7781@artax.karlin.mff.cuni.cz>
 <20061103101901.GA11947@wohnheim.fh-wedel.de>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1908636959-327896193-1162554996=:17174"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1908636959-327896193-1162554996=:17174
Content-Type: TEXT/PLAIN; charset=iso-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT

>>>> new method to keep data consistent in case of crashes (instead of
>>>> journaling),
>>>
>>> Your 32-bit transaction counter will overflow in the real world.  It
>>> will take a setup with millions of transactions per second and even
>>> then not trigger for a few years, but when it hits your filesystem,
>>> the administrator of such a beast won't be happy at all. :)
>>
>> If it overflows, it increases crash count instead. So really you have 2^47
>> transactions or 65536 crashes and 2^31 transactions between each crash.
>
> I am fully aware the counters are effectively 48-bit.  If they were
> just 32-bit, you would likely have hit the problem yourself already.
>
> Jörn

Given the seek time 0.01s, 31-bit value would last for minimum time of 248 
days when doing only syncs and nothing else. 47-bit value will last for 
reasonably long.

Mikulas
--1908636959-327896193-1162554996=:17174--
