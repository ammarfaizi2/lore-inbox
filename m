Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317517AbSHHMU4>; Thu, 8 Aug 2002 08:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317520AbSHHMU4>; Thu, 8 Aug 2002 08:20:56 -0400
Received: from [195.63.194.11] ([195.63.194.11]:7949 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S317517AbSHHMUz>;
	Thu, 8 Aug 2002 08:20:55 -0400
Message-ID: <3D5261AD.9000706@evision.ag>
Date: Thu, 08 Aug 2002 14:18:53 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: martin@dalecki.de, Ingo Molnar <mingo@elte.hu>,
       "Adam J. Richter" <adam@yggdrasil.com>, Andries.Brouwer@cwi.nl,
       johninsd@san.rr.com, linux-kernel@vger.kernel.org
Subject: Re: [bug, 2.5.29, IDE] partition table corruption?
References: <Pine.LNX.4.44.0208081129420.3210-100000@localhost.localdomain>		<3D523B25.5080105@evision.ag>	<1028809830.28883.13.camel@irongate.swansea.linux.org.uk> 	<3D525489.3050209@evision.ag> <1028813033.28882.37.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Alan Cox napisa³:
> 
> So why did you take it out ?

I say it n-th time already dd if=/dev/hda of=/dev/hdb should give
a prefect sector by sector disk clone.

The bugs should be fixed in lilo and not worked around in the kernel.
We have the goal (and in fact obligation for scalability issues) to move
partition scanning out of the kernel space.

Did you ever bother looking the the function in question?

Did you ever look at the missordered code in lilo I cited here?

Did you ever think about what to do about the recurring complains
from people about disk order differences between BIOS and Linux?

Or the whole GET_GEO_BIG confusion ioctl()?

Please compare it with the proper formulas provided at www.phoenix.com
in excellent white papers. (Which can't be linked to directly, since
they  check the refferrer.)

It did contain 'heuristics" which stopped to annoy people just becouse
many have developed the immediate reflex of always adding the linear
parameter during lilo configuration already a very very long time ago
becouse anything else doesn't make much sense and disks have passed the 
512MB or even 4G barrier quite a time ago.

