Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262581AbTKRNh0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 08:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbTKRNh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 08:37:26 -0500
Received: from mail1.btignite.se ([194.213.69.45]:38929 "HELO
	mail2.btignite.se") by vger.kernel.org with SMTP id S262581AbTKRNhY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 08:37:24 -0500
Message-ID: <3FBA2091.70602@lanil.mine.nu>
Date: Tue, 18 Nov 2003 14:37:21 +0100
From: Christian Axelsson <smiler@lanil.mine.nu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031117 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Maciej Zenczykowski <maze@cela.pl>
CC: Pontus Fuchs <pof@users.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: Announce: ndiswrapper
References: <Pine.LNX.4.44.0311181422300.29639-100000@gaia.cela.pl>
In-Reply-To: <Pine.LNX.4.44.0311181422300.29639-100000@gaia.cela.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Zenczykowski wrote:
>>Pontus Fuchs wrote:
>>
>>>Hi,
>>>
>>>Since some vendors refuses to release specs or even a binary
>>>Linux-driver for their WLAN cards I desided to try to solve it myself by
>>>making a kernel module that can load Ndis (windows network driver API)
>>>drivers. I'm not trying to implement all of the Ndis API but rather
>>>implement the functions needed to get these unsupported cards working.
>>
>>Sounds like a plan!
> 
> 
> Definetely agree - question though, are you loading these drivers into 
> ring 0 (kernel space)?  As far as I know linux only supports ring 0 
> (kernel) and 3 (userspace).  However this would seem to be the perfect 
> place to load the binary modules in ring 1 (or even userspace if that was 
> possible...).  I can't say I trust any binary only and/or windows driver 
> to not make a mess of my kernel :)  actually the driver may actually be 
> errorless - it's just designed for a different operating system and thus 
> some unexplainable misshaps could easily happen...

There are development of a userspace driver API I think but I dont know 
the state of it nor the speed impacts.

> While we're at it, loading binary only modules into ring 1 would probably 
> also be a good idea for the NV module et al.  Although I have no idea how 
> hard it would be to make ring 1 function (and whether there actually is 
> any point to doing it in ring 1 instead of ring 3 with iopl/ioperm anyway) 
> and how big the performance penalty for non-ring 0 would be...

See above.

-- 
Christan Axelsson
smiler@lanil.mine.nu


