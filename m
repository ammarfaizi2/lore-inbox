Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263723AbRFHAE4>; Thu, 7 Jun 2001 20:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263726AbRFHAEq>; Thu, 7 Jun 2001 20:04:46 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:44038 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S263723AbRFHAEb>;
	Thu, 7 Jun 2001 20:04:31 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200106080003.f5803wl370740@saturn.cs.uml.edu>
Subject: Re: temperature standard - global config option?
To: bootc@worldnet.fr (Chris Boot)
Date: Thu, 7 Jun 2001 20:03:58 -0400 (EDT)
Cc: dbr@greenhydrant.com (David Rees),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <B745C09D.F8BF%bootc@worldnet.fr> from "Chris Boot" at Jun 07, 2001 11:37:01 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Boot writes:

>>>> Kelvins good idea in general - it is always positive ;-)
>>>>
>>>> 0.01*K fits in 16 bits and gives reasonable range.
...
> OK, I think by now we've all agreed the following:
>  - The issue is NOT displaying temperatures to the user, but a userspace
>    program reading them from the kernel.  The userspace program itself can
>    do temperature conversions for the user if he/she wants.
>  - The most preferable units would be decikelvins, as the value can give a
>    relatively precise as well as wide range of numbers ranging from absolute
>    zero to about 6340 degrees Celsius ((65535 / 10) - 273) which is well
>    within anything that a computer can operate.  It also gives us a good
>    base for all sorts of other temperature sensing devices.
>
> Do we all agree on those now?

I nearly do.

There isn't any need to cram the data into 16 bits.
The offset to Celsius is 273.15 degrees.
So hundredths of a degree, in Kelvin, is a better choice.
