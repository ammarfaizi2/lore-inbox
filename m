Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263254AbRFGVil>; Thu, 7 Jun 2001 17:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263266AbRFGVib>; Thu, 7 Jun 2001 17:38:31 -0400
Received: from ibis.worldnet.net ([195.3.3.14]:11530 "EHLO ibis.worldnet.net")
	by vger.kernel.org with ESMTP id <S263254AbRFGViQ>;
	Thu, 7 Jun 2001 17:38:16 -0400
User-Agent: Microsoft-Outlook-Express-Macintosh-Edition/5.02.2022
Date: Thu, 07 Jun 2001 23:37:01 +0200
Subject: Re: temperature standard - global config option?
From: Chris Boot <bootc@worldnet.fr>
To: David Rees <dbr@greenhydrant.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <B745C09D.F8BF%bootc@worldnet.fr>
In-Reply-To: <20010607094418.A23719@greenhydrant.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>>> Kelvins good idea in general - it is always positive ;-)
>>> 
>>> 0.01*K fits in 16 bits and gives reasonable range.
>>> 
>>> but may be something like K<<6 could be a option? (to allow use of shifts
>>> instead of muls/divs). It would be much more easier to extract int part.
>>> 
>>> just my 2 eurocents.
>> 
>> Why not make it in Celsius ? Is more easy to read it this way.
> 
> It's easier for you as a user to read, but slightly harder to deal with inside
> the code.  
> It's really a user-space issue, inside the kernel should be as standardized as
> possible, and
> Kelvins make the most sense there.

OK, I think by now we've all agreed the following:
 - The issue is NOT displaying temperatures to the user, but a userspace
   program reading them from the kernel.  The userspace program itself can
   do temperature conversions for the user if he/she wants.
 - The most preferable units would be decikelvins, as the value can give a
   relatively precise as well as wide range of numbers ranging from absolute
   zero to about 6340 degrees Celsius ((65535 / 10) - 273) which is well
   within anything that a computer can operate.  It also gives us a good
   base for all sorts of other temperature sensing devices.

Do we all agree on those now?

-- 
Chris Boot
bootc@worldnet.fr

#define QUESTION ((2b) || (!2b))

