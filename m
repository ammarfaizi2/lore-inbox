Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbTLMFD0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 00:03:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263846AbTLMFD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 00:03:26 -0500
Received: from k-kdom.nishanet.com ([65.125.12.2]:25862 "EHLO
	mail2k.k-kdom.nishanet.com") by vger.kernel.org with ESMTP
	id S263792AbTLMFDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 00:03:24 -0500
Message-ID: <3FDA9D7E.2000806@nishanet.com>
Date: Sat, 13 Dec 2003 00:02:54 -0500
From: Bob <recbo@nishanet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.4] Nforce2 oops and occasional hang (tried the lockups patch,
 no difference)
References: <200312131225.34937.ross@datscreative.com.au>
In-Reply-To: <200312131225.34937.ross@datscreative.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ross Dickson wrote:

>Oh, and the modules list: 
> Module Size Used by Tainted: P 
> i2c-dev 4548 0 (unused) 
> i2c-core 13604 0 [i2c-dev]
><snip>
>
>
>I am not certain your problems are nforce2 type specific.
>Standard response: I don't suppose you can try a different stick of ram?
>  
>
Yes, and stock settings with tested ram may
be necessary with nforce2, possibly related to our
timing-related voodoo culture(might overclock
later on in life as timing-related patches evolve).

I have a via board that only recognizes two of
four generic ram sticks, but second stick will cause
an oops soon after. Another via setup will oops
if any fast ram settings(4-way,csl2 etc) is attempted,
though only using tested cas2 ram. "Try a different
stick of ram".

On nforce2 I'm able to use bios "performance"
ram timing but if I manually tweak all the ram
settings up like I can do on other systems, I
get mem-related OOPS with nforce2.

acpi apic lapic amd pre-empt nforce2ide
(once you start you have to go all the way)

>The reason I say that is that oops were very uncommon on either the 
>epox 8rga+ or albatron km18G-pro MOBOS upon which I developed my
>patches. Hard lockups were pretty much all I experienced prior to the 
>patches except for an occasional X fail. Base OS flavour I
>use is Suse 8.2 including gcc version (web updates utilised)
>
>The udma patches are really just a cleanup on the address setup timing so
>I do not think that they are a factor. 
>
>The local apic ack delay timing patch needs athlon cpu and amd/nvidia ide on in 
>kern config to kick in. If you are using it then I highly recommend uniprocessor 
>ioapic config as well to go with it to route the 8254 timer irq0 through pin 0 of 
>ioapic as using the apic config alone leaves a lot of ints generated on irq7 
>which can cause problems. (Reason for 8259 making them spurious on irq7 
>is explained in 8259A data sheet)
>
>Also I now use a small patch to fixup proc info - only if you are using 
>the 64 bit jiffies var hz patch, avail here:
>
>http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/0838.html
>
>If you try acpi=off on boot and it is then not very stable then I think it has 
>little to do with lockups patch as that is my fallback mode when I am 
>playing with apic ioapic code. 
>
>Another fallback I use at times is 
>
>hdparm -Xudma3 /dev/hda
>
>Hope this helps the confusion
>
>Regards
>Ross
>
>  
>

