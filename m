Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319005AbSHSTo2>; Mon, 19 Aug 2002 15:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319006AbSHSTo2>; Mon, 19 Aug 2002 15:44:28 -0400
Received: from imo-m02.mx.aol.com ([64.12.136.5]:3557 "EHLO imo-m02.mx.aol.com")
	by vger.kernel.org with ESMTP id <S319005AbSHSTo1>;
	Mon, 19 Aug 2002 15:44:27 -0400
Message-ID: <3D6113E1.302@netscape.net>
Date: Mon, 19 Aug 2002 15:50:57 +0000
From: Adam Belay <ambx1@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: mochel@osdl.org
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.31 driverfs: patch for your consideration
References: <Pine.LNX.4.44.0208191111100.1048-100000@cherise.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



mochel@osdl.org wrote:

>>Also if You're interested here's the write support for "driver".
>>
>
>Suppose we did support this. If you write the name of a driver to a file, 
>we search the bus's list of drivers for a match. We then let the bus 
>compare the hardware IDs and call probe if it matches. 
>
That's exactly how my code works.

>
>
>One big problem is that the IDs in the driver are marked __devinitdata, so
>they're thrown away after init (if hotplugging is not enabled). So, we 
>would have to change every driver.
>
Found that out when I tested binding the agpgart driver.

> 
>
>Besides, it just doesn't make sense. If $user wants to use a different 
>or third party driver, let them rmmod and insmod. 
>
Ok, I guess that makes sense.  My interface was primarily for special 
cases anyway.  What does need to be done is a user level program that 
finds and loads the proper modules automatically.  Maybe we could use 
the existing hotplug scripts or we could even start from scratch.  Maybe 
we should make a file in the source tree where driver developers can 
list their supported hardware IDs but more importantly documentation on 
the attributes registered into driverfs.

>
>
>>PS:  Would you be interested in a patch that would port the pnpbios
>>driver to the driver model?
>>
>
>Yes. 
>
great!

Thanks,
Adam

