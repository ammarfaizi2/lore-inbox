Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280251AbRKXVeu>; Sat, 24 Nov 2001 16:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280191AbRKXVeb>; Sat, 24 Nov 2001 16:34:31 -0500
Received: from brussel-ns1.xs4all.be ([195.144.67.168]:29706 "EHLO
	brussel-ns1.xs4all.be") by vger.kernel.org with ESMTP
	id <S280110AbRKXVeZ>; Sat, 24 Nov 2001 16:34:25 -0500
Message-ID: <3C002091.8080006@xs4all.be>
Date: Sat, 24 Nov 2001 23:34:57 +0100
From: Didier Moens <moensd@xs4all.be>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: OOPS in agpgart (2.4.13, 2.4.15pre7)
In-Reply-To: <3BFE8799.4070307@dmb.rug.ac.be> <20011123180019.24c19be3.skraw@ithnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear,


Stephan von Krawczynski wrote:

> On Fri, 23 Nov 2001 18:30:01 +0100
> Didier Moens <Didier.Moens@dmb.rug.ac.be> wrote:
> 
> 
>>Hi all,
>>
>>
>>This is my first oops report on lkml, so please be gentle with me.  :)
>>
>>
>>Hardware : IBM A30p (P3-1.2 GHz) with Intel i830 and ATI M6 Radeon 
>>Mobility LY
>>
>>
>>Symptoms : oops when modprobing agpgart, both in the RedHat 2.4.13-0.6 
>>kernel and in a vanilla 2.4.15pre7.
>>
> 
> Hello,
> 
> could be that this code from /drivers/char/agp/agpgart_be.c is bogus:
> 
[]


> 
> Try this patch:
> 


[]


After applying the patch, modprobing agpgart doesn't yield an oops 
anymore ; unfortunately :

# modprobe agpgart
/lib/modules/2.4.15-did/kernel/drivers/char/agp/agpgart.o: init_module: 
No such device
Hint: insmod errors can be caused by incorrect module parameters, 
including invalid IO or IRQ parameters
/lib/modules/2.4.15-did/kernel/drivers/char/agp/agpgart.o: insmod 
/lib/modules/2.4.15-did/kernel/drivers/char/agp/agpgart.o failed
/lib/modules/2.4.15-did/kernel/drivers/char/agp/agpgart.o: insmod 
agpgart failed

And in /var/log/messages :

Nov 24 22:57:49 localhost kernel: Linux agpgart interface v0.99 (c) Jeff 
Hartmann
Nov 24 22:57:49 localhost kernel: agpgart: Maximum main memory to use 
for agp memory: 439M
Nov 24 22:57:49 localhost kernel: agpgart: Detected an Intel 830M, but 
could not find the secondary device.


I don't have the slightest idea what the secondary device is supposed to 
be ; "modprobe radeon" loads the DRM radeon module without any problems 
whatsoever.


Kind regards,

Didier

