Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965182AbWGJSDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965182AbWGJSDn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 14:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965190AbWGJSDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 14:03:43 -0400
Received: from mga03.intel.com ([143.182.124.21]:4230 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S965182AbWGJSDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 14:03:42 -0400
X-IronPort-AV: i="4.06,221,1149490800"; 
   d="scan'208"; a="63771406:sNHT4885015555"
Message-ID: <44B2952A.5030403@intel.com>
Date: Mon, 10 Jul 2006 10:58:02 -0700
From: Auke Kok <auke-jan.h.kok@intel.com>
User-Agent: Mail/News 1.5.0.4 (X11/20060617)
MIME-Version: 1.0
To: Molle Bestefich <molle.bestefich@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [bug] e100 bug: checksum mismatch on 82551ER rev10
References: <62b0912f0607090434q735e36b7pd9ab35baf0914e7a@mail.gmail.com>	 <44B2716A.3030009@intel.com>	 <62b0912f0607100945o574dcce8w8f734e5828bdcaa8@mail.gmail.com>	 <44B28C5A.5090605@intel.com> <62b0912f0607101041w69bd2a19t635a438f378e0e24@mail.gmail.com>
In-Reply-To: <62b0912f0607101041w69bd2a19t635a438f378e0e24@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jul 2006 17:58:47.0770 (UTC) FILETIME=[7E27A3A0:01C6A44A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Molle Bestefich wrote:
> Auke Kok wrote:
>> > Every single IP130 I've had my hands on has had an EEPROM that the
>> > Linux driver declared bad.
>>
>> that means that whoever is selling you the IP130's is consistently 
>> putting on
>> bad EEPROMs, which is *very* bad. Which vendor is that? They can fix this
>> problem for you and for *everyone* else they have sold and will sell 
>> IP130's
>> to in the future.
> 
> Nokia.
> 
> Maybe they've changed the BABA magic, or the checksum logic entirely,
> to prevent other software than their own OS from running.

in almost all cases where a bad EEPROM checksum is found on a board the vendor 
has changed settings in the EEPROM image without recalculating the checksum.

>> > I'm afraid that it's not the board that's at fault, it's the driver.
>>
>> No it is not. The NIC is supported (you can even call Intel for first 
>> line
>> support) but if your vendor put a bad EEPROM image on it then all bets 
>> are
>> off.  Intel provides the vendors with the proper tools to make valid 
>> EEPROMs,
>> the driver checks them for a very good reason.
> 
> You're completely sure that the EEPROM check is correct for this
> particular revision of this particular chip?

It's valid for every piece of network silicon that has an EEPROM ever made.

> (Do you happen to know where the EEPROM is located, by the way?

it's in the NIC itself. In your case, where you have 3 separate chips, there 
will be 3 different EEPROM images total.

>> How can you tell? Do you know if jumbo frames work correctly?  Is the 
>> device
>> properly checksumming? is flow control working properly?  These and 
>> many, many
>> more settings are determined by the EEPROM.  Seemingly it may work 
>> correctly,
>> but there is no guarantee whatsoever that it will work correctly at 
>> all if the
>> checksum is bad.  Again, you can lose data, or worse, you could 
>> corrupt memory
>> in the system causing massive failure (DMA timings, etc). Unlikely? 
>> sure, but
>> not impossible.
> 
> They've been used in production environments for years.

all the more reason to suggest that Nokia is forgetting to update the checksums :)

Cheers,

Auke
