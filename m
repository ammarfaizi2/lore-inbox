Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315277AbSHHSLB>; Thu, 8 Aug 2002 14:11:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317326AbSHHSLB>; Thu, 8 Aug 2002 14:11:01 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:27119 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315277AbSHHSLA>; Thu, 8 Aug 2002 14:11:00 -0400
Subject: Re: [bug, 2.5.29, IDE] partition table corruption?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: martin@dalecki.de
Cc: Ingo Molnar <mingo@elte.hu>, "Adam J. Richter" <adam@yggdrasil.com>,
       Andries.Brouwer@cwi.nl, johninsd@san.rr.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <3D5261AD.9000706@evision.ag>
References: <Pine.LNX.4.44.0208081129420.3210-100000@localhost.localdomain>		<3D523B25.5
Message-Id: <20020808181100Z315277-685+26763@vger.kernel.org>
Date: Thu, 8 Aug 2002 14:11:00 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	
	080105@evision.ag>	<1028809830.28883.13.camel@irongate.swansea.linux.org.uk>
	 <3D525489.3050209@evision.ag>
	<1028813033.28882.37.camel@irongate.swansea.linux.org.uk> 
	<3D5261AD.9000706@evision.ag>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 08 Aug 2002 20:34:07 +0100
Message-Id: <1028835247.28882.50.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0

On Thu, 2002-08-08 at 13:18, Marcin Dalecki wrote:
> I say it n-th time already dd if=/dev/hda of=/dev/hdb should give
> a prefect sector by sector disk clone.

The specific case of the hack for EZdisk I have no issue with the
general problem I do

> The bugs should be fixed in lilo and not worked around in the kernel.
> We have the goal (and in fact obligation for scalability issues) to move
> partition scanning out of the kernel space.

Partition handling doesn't show up in any scalability benchmarks. Show
me an IBM 8 way with partition reading showing up in lockmeter
 
> Did you ever bother looking the the function in question?
Yes

> Did you ever look at the missordered code in lilo I cited here?

Did you ever think that it 
 
> It did contain 'heuristics" which stopped to annoy people just becouse
> many have developed the immediate reflex of always adding the linear
> parameter during lilo configuration already a very very long time ago
> becouse anything else doesn't make much sense and disks have passed the 
> 512MB or even 4G barrier quite a time ago.

So fix the heuristics to the official algorithm. Thats a good thing to
do and test in a development kernel tree.

And btw lots of people still use < 512Mb and < 4G disks. No doubt you'd
prefer your kernel only ran on a pentiumII or higher

Alan

