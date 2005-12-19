Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932704AbVLSJXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbVLSJXZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 04:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932709AbVLSJXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 04:23:25 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:53664 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932704AbVLSJXY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 04:23:24 -0500
Message-ID: <43A67CF3.4080004@aitel.hist.no>
Date: Mon, 19 Dec 2005 10:27:15 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pekka Enberg <penberg@cs.helsinki.fi>
CC: Puneet Vyas <puneetvyas@gmail.com>, Ismail Donmez <ismail@uludag.org.tr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <20051211180536.GM23349@stusta.de>	 <Pine.LNX.4.61.0512152356190.13568@yvahk01.tjqt.qr>	 <200512160112.30179.ismail@uludag.org.tr> <43A239B4.8010309@gmail.com> <84144f020512152355p1d0934bdqe74fbe898c236982@mail.gmail.com>
In-Reply-To: <84144f020512152355p1d0934bdqe74fbe898c236982@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:

>Hi,
>
>On 12/16/05, Puneet Vyas <puneetvyas@gmail.com> wrote:
>  
>
>>If the learned folks here think that "ndiswrapper" is some user space
>>program that people can live without than at least
>>    
>>
ndiswrapper can be fixed to work in a 4k stack environment,
even if the windows driver in use needs more than 4k.  This
requires some work, because ndiswrapper will then have to
manage its own stack instead of simply using the provided
kernel stack.  It is up to all people who want ndiswrapper to
actually do this work.

Note that this work ought to be done anyway, as windows
drivers really assumes they can use 12k of stack, which they
cannot do even with the current 8k stack.

>>3 people in my house are doomed. We like to use linux but do not have
>>luxury that Ismail enjoys. At least windows
>>does not make such decisions on my behalf. Sigh.
>>    
>>
Windows makes a lot of such decisions - you just never see them
if you come from the windows world.  Could I run windows on my
machine with two keyboards, supporting two simultaneous users?
And in 64-bit mode too?  Not now. 

Could all the people with other non-x86 processors run windows? No.



>
>While I understand that you're frustrated, please direct it towards
>your vendor who is unwilling to open up the hardware documentation.
>The binary-only drivers you are using are not supported on Linux (you
>took them from Windows, remember) and the only way you're ever going
>to get reliable wireless support is by reverse engineering or vendor
>opening up the specs.
>
>                                Pekka
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

