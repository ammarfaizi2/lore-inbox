Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265320AbTLHDQk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 22:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265321AbTLHDQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 22:16:40 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:30988 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S265320AbTLHDQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 22:16:37 -0500
Message-ID: <3FD3F15F.4090309@nishanet.com>
Date: Sun, 07 Dec 2003 22:34:55 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Catching NForce2 lockup with NMI watchdog - found
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F87E@mail-sc-6.nvidia.com>	<3FD1199E.2030402@gmx.de> <20031206081848.GA4023@localnet> <frodoid.frodo.87zne6chry.fsf@usenet.frodoid.org>
In-Reply-To: <frodoid.frodo.87zne6chry.fsf@usenet.frodoid.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wasn't this formerly fixed by a kernel config
option to not detect cpu idle on amd cpu's?
I don't see that in 2.6

Julien Oster wrote:

>cheuche+lkml@free.fr writes:
>
>Hello,
>
>  
>
>>>So gals and guys, try disabling cpu disconnect in bios and see whether 
>>>aopic now runs stable.
>>>      
>>>
>
>  
>
>>Yes that fix it. Well time will tell but I cannot make it crash with
>>hdparm -tT or cat /dev/hda so far. I'm dumping hda to /dev/null right
>>now.
>>After testing to make it crash, I used athcool to reenable CPU
>>disconnect, and guess what, test after that just crashed the box.
>>You found the problem, congratulations.
>>    
>>
>
>Well, now I'm stunned.
>
>With APIC and ACPI enabled, my machine isn't even able to boot
>completely, it'll most certainly crash before the init scripts are
>finished.
>
>Now, I modified the init scripts to do "athcool off" as the first
>thing at all (I don't have any "CPU disconnect" BIOS setting) and it
>not only booted, but I even can't seem to make it crash using my
>hdparm/grep/whatever tests...
>
>I don't know if it's "rock solid" yet, but at least the difference is
>huge. It really seems like that made the problem go away!
>
>Regards,
>Julien
>  
>


