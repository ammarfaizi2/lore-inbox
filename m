Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265584AbUABPjN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 10:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265586AbUABPjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 10:39:13 -0500
Received: from firewall.conet.cz ([213.175.54.250]:3484 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265584AbUABPjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 10:39:08 -0500
Message-ID: <3FF59098.3030904@conet.cz>
Date: Fri, 02 Jan 2004 16:39:04 +0100
From: Libor Vanek <libor@conet.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?windows-1250?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: Syscall table AKA hijacking syscalls
References: <3FF56B1C.1040308@conet.cz> <20040102135713.GA9935@vestdata.no>
In-Reply-To: <20040102135713.GA9935@vestdata.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>>I'm writing some project which needs to hijack some syscalls in VFS 
>>layer. AFAIK in 2.6 is this "not-wanted" solution (even that there are 
>>some very nasty ways of doing it - see 
>>http://mail.nl.linux.org/kernelnewbies/2002-12/msg00266.html )
>>
>>Also I've found out that Linus stated that intercepting syscalls is "bad 
>>thing" (load module a, load module b, unload module b => crash) but I 
>>think that there are some very good reasons (and ways) to do it (see 
>>http://syscalltrack.sourceforge.net ). My main reason to do it is that I 
>>want my GPLed module to be able to modify some VFS syscalls without 
>>patching and recompiling whole kernel and rebooting the machine.
>>    
>>
>
>As part of the openxdsm-project we wrote an syscall-intercept module
>that "solves" the (load module a, load module b, unload module b =>
>crash) part by providing a common infrastructure for intercepting
>syscalls.
>  
>
The code looks very nice'n'simple but it won't run on 2.6 because 
mentioned hidden sys_call_table. But I can imagine that this with some 
small tweaks can be integrated into 2.6 to provide generall 
infrastructure for syscall hijacking when really needed.


-- 

Libor Vanek


