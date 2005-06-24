Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263096AbVFXQLj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263096AbVFXQLj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 12:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263036AbVFXQLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 12:11:38 -0400
Received: from kirby.webscope.com ([204.141.84.57]:7125 "EHLO
	kirby.webscope.com") by vger.kernel.org with ESMTP id S263119AbVFXQKi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 12:10:38 -0400
Message-ID: <42BC306A.1030904@m1k.net>
Date: Fri, 24 Jun 2005 12:10:18 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: vojtech@suse.cz
CC: Frank Peters <frank.peters@comcast.net>, linux-kernel@vger.kernel.org
Subject: isa0060/serio0 problems -WAS- Re: Asus MB and 2.6.12 Problems
References: <20050624113404.198d254c.frank.peters@comcast.net>
In-Reply-To: <20050624113404.198d254c.frank.peters@comcast.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Peters <frank.peters@comcast.net> wrote:

>After downloading and compiling the latest version 2.6.12, my
>keyboard becomes unresponsive and dead following the boot process.
>This doesn't occur all of the time, but only some of the time.
>In particular, the follwing boot up message will be seen at
>sporadic places among the other text output:
>
>input: AT Translated Set 2 keyboard on isa0060/serio0
>
>When this message does not occur anywhere in the boot messages,
>the keyboard is not functional.  When the message does occur, then
>the keyboard will respond, but sometimes with an erratic key
>repeat rate.  After rebooting several times I can usually get
>the system up and running smoothly, but with this current kernel
>2.6.12, there is no guarantee that it will boot properly at any
>given time.
>  
>
...

>My system is an ASUS P4B533 motherboard with a Pentium 3.6 Ghz
>Hyperthreaded processor and 1 GHz RAM.  The kernel is the stock
>linux kernel (compiled with gcc-2.95.3) and the rest of my software
>is self-compiled (i.e. no distribution).
>
>If I disable ACPI, either by compiling a new 2.6.12 kernel or
>through boot up parameters, the keyboard will respond normally
>without any problems, but the kernel will not recognize my
>hyperthreaded processor.  Only one CPU will be initialized and
>active.
>
>Thus, I can enjoy a problem-free 2.6.12 kernel if I choose to 
>sacrifice ACPI and hyperthreading.
>  
>
...

>If anyone has any suggestions or needs any more information,
>please CC me at the address frank.peters@comcast.net as I am not
>a subscriber to the list.
>  
>
I am having the same problem with my Shuttle FT61 motherboard, although 
I have not tried to disable ACPI... Until now I thought I just had a 
faulty keyboard, as my method to fix this was to unplug the keyboard and 
plug it back in after bootup.  When this happens, I see this in dmesg as 
the last line:

input: AT Translated Set 2 keyboard on isa0060/serio0

I am also having problems with my AUX mouse, as seen in message

Subject: 2.6.12-rc5-mm1 breaks serio: i8042 AUX port

Frank, are you having problems with your ps/2 mouse port as well?

I haven't spent enough time experimenting with this, as I thought it 
might have had something to to with my hardware / KVM switch.  Seeing 
Frank's message is the reason why I've decided to chime back in on this.

As a clarification, I have been having these keyboard problems 
intermittently, regardless of whether I'm using -mm or mainline kernel.  
I was NOT having this problem in 2.6.11  I wasn't having the psaux mouse 
problems in 2.6.11 either  .... I unplugged my psaux mouse from that 
machine before 2.6.12-mainline was released, so I don't know if those 
symptoms are still present.  (using USB mouse now instead).  I am 
currently in my office, so I can't test this right now, and I will be 
away for this weekend.  I'll be able to make these tests again come 
Sunday night/Monday.   ...and I will try it this time WITHOUT the kvm 
switch.

-- 
Michael Krufky


