Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbTL1Vp3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 16:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbTL1Vp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 16:45:29 -0500
Received: from ip3e83a512.speed.planet.nl ([62.131.165.18]:56620 "EHLO
	made0120.speed.planet.nl") by vger.kernel.org with ESMTP
	id S262081AbTL1Vp0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 16:45:26 -0500
Message-ID: <3FEF4EF2.4080303@planet.nl>
Date: Sun, 28 Dec 2003 22:45:22 +0100
From: Stef van der Made <svdmade@planet.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20031227
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: wrlk@riede.org
CC: linux-kernel@vger.kernel.org
Subject: Re: The survival of ide-scsi in 2.6.x
References: <20031226181242.GE1277@linnie.riede.org> <3FED7E80.20800@planet.nl> <20031227131724.GG1277@linnie.riede.org>
In-Reply-To: <20031227131724.GG1277@linnie.riede.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Willem,

The standard stuff like mt -f /dev/ht0 status etc etc works. But tar 
doesn't wan't to-do backups anymore both with and witout the patch on a 
2.6.0 kernel. I don't have a 2.4.x kernel handy to test if it still 
works with those kernels and my drive.

What I've done is the following:

bash-2.05# tar -cvb 64 -f /dev/ht0 /
tar: Removing leading `/' from absolute path names in the archive
 
lost+found/
usr/
usr/X11
usr/adm
usr/bin/
usr/bin/w
usr/bin/ar
tar: Cannot write to /dev/ht0: Invalid argument
tar: Error is not recoverable: exiting now

It looks as if the backup starts but it almost immediatly ends after the 
drive does some spinning and reading and or writing.

Cheers

Stef

Willem Riede wrote:

>On 2003.12.27 07:43, Stef van der Made wrote:
>  
>
>>Willem Riede wrote:
>>
>>snip
>>
>>    
>>
>>>(By the way, ide-tape contains code for the ATAPI version, the 
>>>DI-30, but that code is old and has serveral known problems - 
>>>I'd like to see it removed - or at least deprecated - I will do 
>>>that myself later if people want me to.)
>>>
>>>      
>>>
>>snip
>>
>>After some fixing on ide-scsi my DI-30 is now working fine. I don't know 
>>of any bugs in it. All works fine for me. 
>>    
>>
>
>If your system ever loses an interrupt form the DI-30 you'll find out :-)
>
>  
>
>>                                          Getting rid if ide-scsi might 
>>be a good idea but it ain't going to be easy as a lot of programs are 
>>using the code.
>>    
>>
>
>I was actually trying to save ide-scsi, as we need it for the DI-30 + osst.
>
>  
>
>> If you need a tester for the di-30 please feed me the patches and I'll 
>>play around with them.
>>    
>>
>
>Well, you could try the patch in the oiginal mail, and there is a new 
>version of osst on osst.sourceforge.net that you could test.
>
>Thnaks, Willem Riede.
>
>  
>

