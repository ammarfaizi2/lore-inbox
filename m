Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317851AbSGKP5k>; Thu, 11 Jul 2002 11:57:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317852AbSGKP5j>; Thu, 11 Jul 2002 11:57:39 -0400
Received: from [195.63.194.11] ([195.63.194.11]:46853 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S317851AbSGKP5j> convert rfc822-to-8bit; Thu, 11 Jul 2002 11:57:39 -0400
Message-ID: <3D2DAB7E.30208@evision-ventures.com>
Date: Thu, 11 Jul 2002 17:59:58 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0.0) Gecko/20020611
X-Accept-Language: pl, en-us
MIME-Version: 1.0
To: Thunder from the hill <thunder@ngforever.de>
CC: Hannu Savolainen <hannu@opensound.com>,
       george anzinger <george@mvista.com>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Linux <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
References: <Pine.LNX.4.44.0207110651430.5067-100000@hawkeye.luckynet.adm>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

U¿ytkownik Thunder from the hill napisa³:
> Hi,
> 
> On Thu, 11 Jul 2002, Hannu Savolainen wrote:
> 
>>This is not a problem at all. Just define HZ as:
>>
>>extern int system_hz;
>>#define HZ system_hz
>>
>>After that all code will use variable HZ. Changing HZ on fly will be
>>dangerous. However HZ can be made a boot time (LILO) parameter.
> 
> 
> OK, that's probably a start. As the next step, I'd recommend that the 
> maintainers and their supporters try to replace the static HZ with 
> possibly-dynamic system_hz. The third step would be to have guys like Ingo 
> to tune system_hz to be really dynamic.
> 
> Cool idea, anyway.

Just remember plase to map it to /proc/sys/kernel/xxx
So we could implement the following properly:

_SC_CLK_TCK            CLK_TCK       Ticks per second          (clock_t)

(Taken from Solaris pecs.)

Unless of course we stick to the fact that HZ exposed
to user land remains an arch specific constant as in 2.5.25 which
I think is the more prefferable solution.

Pitty is RedHat beta does mess with this! The 2.5.25 solutoin from
Linus is far better.

