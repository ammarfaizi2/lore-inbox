Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266496AbUBLQLL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 11:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266499AbUBLQLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 11:11:11 -0500
Received: from pop.gmx.de ([213.165.64.20]:5072 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266496AbUBLQLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 11:11:05 -0500
X-Authenticated: #4512188
Message-ID: <402BA596.6000906@gmx.de>
Date: Thu, 12 Feb 2004 17:11:02 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm4
References: <20040115225948.6b994a48.akpm@osdl.org> <4007B03C.4090106@gmx.de> <400EC908.4020801@gmx.de> <200401211920.i0LJKZ2a003504@turing-police.cc.vt.edu> <402AAB2C.8050207@gmx.de> <200402120552.i1C5qAHS024041@turing-police.cc.vt.edu>            <402B2BAE.9090208@gmx.de> <200402120846.i1C8k6x7006645@turing-police.cc.vt.edu> <402B7C7F.1040103@gmx.de>
In-Reply-To: <402B7C7F.1040103@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prakash K. Cheemplavam wrote:
> Valdis.Kletnieks@vt.edu wrote:
> 
>> On Thu, 12 Feb 2004 08:30:54 +0100, "Prakash K. Cheemplavam" said:
>>
>>
>>> Well, I don't know whether my system actually locks up, it is like it 
>>> seems the log gets flooded (when I wait long enough) but I cannot do 
>>> anything with the system at that point, ie it seems like frozen.
>>
>>
>>
>> I don't think anybody's going to be able to shoot that bug report 
>> without more
>> info.  "seems like frozen" doesn't give us much to go on.  Does the 
>> machine
>> still ping/ssh/etc on the net?  Is it totally locked up?  Any disk 
>> activity
>> lights left on/flickering, indicating life? Can you get a serial 
>> console or
>> kgdb-ethernet or something to see if there's an oops/panic?
> 
> 
> Hmm, I'll test those bk-snapshots and when it locks up, I'll try to 

So, I tried 2.6.2-rc1-bk1 and it locks up. How can I find out which 
patches it incorporated, so that I can filter out that bugger? (more see 
down, this time it was type 2)

I dunno about kgdb-ethernet (but I'll see whether I'll understand it) 
nor do I have a serial console.

> Maybe it is a nforce2 issue then. I think it is ACPI specific. I'll also 
> try compiling latest kernel without ACPI and report back.

I tried 2.6.3-rc1-mm1 without ACPI and it lock up up (type 1). I now can 
tell about two type of lock-up (maybe due to the same cause):

1) complete freeze, nothing possible, not able to read machine from 
network, must use reset button
2) freeze, but only mouse movement (nothing reacts though, keyboard 
neither) is possibel and log is flooded with error I posted, I can still 
reach machine via network and do a gracefull shutdown (killing X wasn't 
passible)

Prakash
