Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275445AbTHIXR7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 19:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275447AbTHIXR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 19:17:59 -0400
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:35685 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S275445AbTHIXR4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 19:17:56 -0400
Message-ID: <3F35812C.10404@sbcglobal.net>
Date: Sat, 09 Aug 2003 18:18:04 -0500
From: Wes Janzen <superchkn@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: reiserfs-list@namesys.com
Subject: Re: FS Corruption with VIA MVP3 + UDMA/DMA
References: <16128.19218.139117.293393@charged.uio.no> <3F34E6D1.7030900@sbcglobal.net> <20030809162710.GC29647@mail.jlokier.co.uk> <200308091943.25231.insecure@mail.od.ua> <20030809173850.GA30143@mail.jlokier.co.uk>
In-Reply-To: <20030809173850.GA30143@mail.jlokier.co.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nothing runs on this one ;-)

WinXP/2003 will die from registry and unrecoverable NTFS filesystem 
corruption.  Win98 will randomly corrupt driver files eventually leading 
to an unbootable system, or worse, a completely corrupted filesystem as 
scandisk happily crosslinks all the files (experienced this several 
times, just thought it was the hard drives and windows...since the 
drives would fail a few months later and since I had past experience 
with a Pentium 166 and HX system running Win95 doing this).

Linux fared better, but still would corrupt the filesystem, sometimes 
leading to an unusable system say if an important library is moved to 
lost+found during fsck.  It was much more reliable than any Windows 
install and easily repairable.  With windows, I had no choice but to 
re-install (backing up the registry after every boot worked until NTFS 
would eventually die).  I lost a few data and help files under linux, 
but at this point I backed up all the time anyway (after my first 
installation was hopelessly mangled).

I've tried several PCI tweaks with 2.4 which didn't really seem to cure 
anything.  My powertweak doesn't seem to like the 2.5 series kernels, so 
I haven't tried that.  Not that it seems to matter, the promise 
controllers have much better throughput anyway even with the same modes 
and settings in hdparm.  I tried all the hdparm combinations of dma 
modes and other settings with only a slight decrease in the chance of 
corruption and a corresponding dive in throughput.  It worked through 
2.5.74, but I finally disabled it for everything except my IDE ZIP drive 
and stuck in another promise card after concluding that it was just 
hopelessly broken.

It would have been nice if 2.4 would just refuse to use DMA, that way 
I'd have known about the problem much earlier.  I would think with all 
the stuff in the kernel about the RZ1000, the problems with the MVP3 
would be mentioned as well.  As just a typical end user I couldn't 
figure out why Linux and reiserfs, which are supposed to be so stable 
wouldn't weren't.  At this point I'd already run exhaustive memory , 
hard drive bad sector, and CPU tests without any failures so I was 
pretty certain it wasn't a hardware issue.  Everyone I knew had crashes 
with Windows so those didn't surprise me so much.

It's a decent computer for web browsing and let's me gauge the 
performance of my business apps.  It's a pretty good low-end target 
machine now that it doesn't write garbage to my drives.

I just think this should be documented in case someone sets up a 
proxy/firewall machine with this configuration.  For the majority of 
home users, any higher-end machine is probably wasted on such an 
application.  I setup such a system to share my parents dial-up 
connection over a wireless network.  Of course, it's using an HX chipset 
and P233MMX so it's rock solid, only needing rebooted when the modem 
locks up (happened twice since I set it up a year ago).  Even though 
it's running 2.4.18 and my dad likes to reset it rather than 
CTRL-ALT-DEL when the modem locks up, it has yet to corrupt reiserfs. 

That's the kind of stability that got me really wondering about my system...

Jamie Lokier wrote:

>insecure wrote:
>  
>
>>>The VP2/97 also had severe problems with DMA.  I could never run
>>>standard kernels on mind in the 2.0 days, and distro installs would
>>>always lock up during installation, although Mandrake 8 seemed
>>>reliable so something improved.
>>>      
>>>
>>I had a VIA VPX sometime ago. AFAIR it worked fine...
>>
>>I suspect PCI conf tweaks etc could work around
>>this trouble. I'm afraid there won't be much interest
>>in fixing these oldies. For example, I got rid of that
>>board (exchanged for Socket A one) -> no way to test fixes :(
>>    
>>
>
>I found a hdparm command which fixed it, though it wasn't much use
>during distro installs.  It was very pleasant to see Mandrake 8 just
>work.  Fwiw, Windows 95, 98 and NT4 have no problems on the box.  It's
>now my "Internet Explorer 4" test rig :)
>
>-- Jamie
>
>  
>

