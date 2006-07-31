Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932531AbWGaVHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932531AbWGaVHs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 17:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWGaVHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 17:07:47 -0400
Received: from charlieb.ott.istop.com ([66.11.174.133]:11663 "HELO
	charlieb.ott.istop.com") by vger.kernel.org with SMTP
	id S932531AbWGaVHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 17:07:47 -0400
Date: Mon, 31 Jul 2006 17:07:45 -0400 (EDT)
From: Charlie Brady <charlieb@budge.apana.org.au>
X-X-Sender: charlieb@e-smith.charlieb.ott.istop.com
To: linux-kernel@vger.kernel.org
Subject: Re: [bug] e100 bug: checksum mismatch on 82551ER rev10
Message-ID: <Pine.LNX.4.61.0607311653360.24450@e-smith.charlieb.ott.istop.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Molle Bestefich wrote:
>
>> Auke Kok wrote:
>>
>> If you have received a motherboard or card with a broken EEPROM 
>> then your card is in a limbo state - it might work but results are 
>> unreliable and may cause your entire system to break (and even data
>> corruption).

Sure, and on the other hand, it might work (seemingly) perfectly, as it 
has done in the past, and will continue to do so as long as the owner 
wishes it to.

>> You should contact the hardware vendor and have the board replaced or
>> upgraded with a proper EEPROM. Continuing to work with the corrupted
>> EEPROM image that you have now can seriously hurt you later on.

Or a driver change can hurt me *right now*, by leaving my system without 
connectivity.

> Every single IP130 I've had my hands on has had an EEPROM that the
> Linux driver declared bad.

I'm now seeing this problem with a Thinkpad T23. I have a second T23 I can 
test, and will try to do so tonight.

I second the request to at least have a driver option to ignore checksum 
failures.

Auke said earlier:

>> The NICs are working perfectly.
>
> How can you tell? Do you know if jumbo frames work correctly? Is the
> device properly checksumming? is flow control working properly? These
> and many, many more settings are determined by the EEPROM. Seemingly it
> may work correctly, but there is no guarantee whatsoever that it will work
> correctly at all if the checksum is bad. Again, you can lose data, or
> worse, you could corrupt memory in the system causing massive failure (DMA
> timings, etc). Unlikely? sure, but not impossible.

Let's assume that these things are all true, and the NIC currently does 
not work perfectly, just imperfectly, but acceptably. With the recent 
driver change, it now does not work at all. That's surely a bug in the 
driver.

---
Charlie
