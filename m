Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318993AbSHST3B>; Mon, 19 Aug 2002 15:29:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318995AbSHST3B>; Mon, 19 Aug 2002 15:29:01 -0400
Received: from imo-d04.mx.aol.com ([205.188.157.36]:642 "EHLO
	imo-d04.mx.aol.com") by vger.kernel.org with ESMTP
	id <S318993AbSHST3A>; Mon, 19 Aug 2002 15:29:00 -0400
Message-ID: <3D61104E.7050002@netscape.net>
Date: Mon, 19 Aug 2002 15:35:42 +0000
From: Adam Belay <ambx1@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: mochel@osdl.org
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.31 driverfs: patch for your consideration
References: <Pine.LNX.4.44.0208191103160.1048-100000@cherise.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



mochel@osdl.org wrote:

>
>patch -l does not imply cleanly. That will ignore the whitespace munging 
>that your MUA is doing. 
>
You're right it's incorrect to say cleanly

>>also I was wondering if you think resource management variables (irq,
>>io, dma, etc) should live in the device structure like power management
>>variables do?  Global resource management seams interesting to me,
>>although there already is a proc interface that does list resources, I'm
>>wondering if the driver model is a good place to put such an interface?
>>
>
>Yes. We talked about doing that from the very beginning, and were going to 
>see how things worked out. There was some discussion about this at OLS, 
>too. But, I'm not sure it's ready for it yet.
>
That's great, I think there's a big advantage doing this because if this 
data lies in the driver model code then it's very easy to standardize 
interfaces for hardware and power management

>
>
>What would be nice would be some way to cleanly represent conditional 
>attributes of devices, like resource and power management. I think I 
>almost have something with the device interface stuff, but I fear it's a 
>fine line to cross over into Abstraction Hell... 
>
Could you please send me a patch, if there is one, concerning your work 
with conditional attributes, I'd love to take a look.  If we could work 
something out like this it would solve all kinds of problems.  I'll look 
into it.  Remember that devfs patch I had a while ago.  Instead of using 
devfs handles I could use kdev_t and export the major and minor through 
a conditional attribute.  If so should a list of major and minor pairs 
be in one file?


Also when you say conditional attributes do you mean conditional in the 
device structure as well.  In other words do you mean a list or hash of 
attributes in the device structure?

Thanks,
Adam

