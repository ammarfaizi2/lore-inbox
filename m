Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131974AbRDAEfu>; Sat, 31 Mar 2001 23:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131980AbRDAEfj>; Sat, 31 Mar 2001 23:35:39 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:34831 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S131974AbRDAEfa>; Sat, 31 Mar 2001 23:35:30 -0500
Message-Id: <200104010434.f314Yks62066@aslan.scsiguy.com>
To: Peter Enderborg <pme@ufh.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: Version 6.1.6 of the aic7xxx driver availalbe 
In-Reply-To: Your message of "Sat, 31 Mar 2001 20:05:10 +0200."
             <3AC61C54.B2AEE21C@ufh.se> 
Date: Sat, 31 Mar 2001 21:34:46 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>"Justin T. Gibbs" wrote:
>
>> >I upgraded to 2.4.3 from 2.4.1 today and I get a lot of recovery on the scs
>i
>> >bus.
>> >I also upgraded to the "latest" aic7xxx driver but still the sam problems.
>> >A typical revery in my logs.

This really looks like you bus is not up to snuff.  We timeout during
a write to the drive.  Although the chip has data to write, the target
has stopped asking for data.  This is a classic symptom of a lost signal
transition on the bus.  The old driver may have worked in the past
because it was not quite as fast at driving the bus.  2.2.19 uses the
"old" aic7xxx driver but includes some performance improvements over 2.2.18.
The new driver has similar improvements.  Check your cables.  Check
your terminators.  Etc.

--
Justin
