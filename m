Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274375AbRITJFm>; Thu, 20 Sep 2001 05:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274377AbRITJFc>; Thu, 20 Sep 2001 05:05:32 -0400
Received: from [195.66.192.167] ([195.66.192.167]:30226 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S274375AbRITJF2>; Thu, 20 Sep 2001 05:05:28 -0400
Date: Thu, 20 Sep 2001 12:03:35 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <10214879024.20010920120335@port.imtp.ilyichevsk.odessa.ua>
To: Arjan van de Ven <arjanv@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
In-Reply-To: <3BA8EA04.E55BAA02@redhat.com>
In-Reply-To: <9oafeu$1o0$1@penguin.transmeta.com>
 <Pine.LNX.4.30.0109191141560.24917-100000@anime.net>
 <3BA8EA04.E55BAA02@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arjan,
Wednesday, September 19, 2001, 9:55:00 PM, you wrote:
>> AFAIK noone has even tested it yet to see what it does to performance! Eg
>> it might slow down memory access so that athlon-optimized memcopy is now
>> slower than non-athlon-optimized memcopy. And if it turns out to be the
>> case, we might as well just use the non-athlon-optimized memcopy instead
>> of twiddling undocumented northbridge bits...

AvdV> Ok but that part is simple: run
AvdV> http://www.fenrus.demon.nl/athlon.c

Well, this tester is really useful.
Some bugs though:
* fast_copy_page() does fsave instead of frstor
* do we need femms before frstor?
  My PII at work does not even execute femms...
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
http://port.imtp.ilyichevsk.odessa.ua/vda/


