Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267309AbSLRSMK>; Wed, 18 Dec 2002 13:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267311AbSLRSMK>; Wed, 18 Dec 2002 13:12:10 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:6651 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S267309AbSLRSMI>; Wed, 18 Dec 2002 13:12:08 -0500
Message-ID: <3E00BC48.3040506@google.com>
Date: Wed, 18 Dec 2002 10:19:52 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Bradford <john@bradfords.org.uk>
CC: "D.A.M. Revok" <marvin@synapse.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19, don't "hdparm -I /dev/hde" if hde is on a Asus A7V133
 Promise ctrlr, or...
References: <200212152337.gBFNbZp9002196@darkstar.example.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The promise chips often respond to starnge situations by locking up the 
PCI bus.  In particular they assert the wait signal and do not release 
it.  This locks the system up had the next time the CPU tries to access 
the PCI bus.  The machine is dead in your case and needs to be reset.

I've sent a PCI bus trace of this happening to Promise and have not yet 
heard anything back yet.

    Ross

John Bradford wrote:

>>man, the Magic SysReq key didn't work ( at all ):
>>it were DEAD
>>The drive-light stayed on for 10+ hours, nothing happening ( that I could 
>>figure out ) the whole time.  It /stayed/ dead.
>>
>>/dev/hde is part of a RAID-5 in my system ( because I no longer trust 
>>anything else ), and this only happens on drives connected onto the 
>>Promise controller.
>>
>>Oh, yeah, I forgot to include this:
>>trying to touch/activate/read the S.M.A.R.T. in any drive on the Promise 
>>kills it, too.  Can't activate the reliability-system without killing 
>>the kernel? /that's/ ironic, eh?
>>
>>
>>As for having another terminal connected to my home machine...
>>1. if the kernel's dead, then how's that gonna work, and
>>    
>>
>
>Maybe just the console was not responding.
>
>If I start X with /dev/null as the core pointer, the console locks
>completely, but I can still log in on a serial terminal.
>
>I have seen machines which will mostly stop responding when you issue
>a sleep command to a disk, E.G.
>
>hdparm -Y /dev/hda
>
>you can't terminate the process with control-C, for example, but if
>you are logged in on another virtual terminal, or have another
>terminal window open in X, you can reset the interface, and the
>machine will respond again.
>
>  
>
>>2. why have 2 terminals on one machine when I'm a hermit?
>>    
>>
>
>Why not?  I read and write a lot of E-Mail on a serial terminal right
>next to my main console, and what about debugging SVGALIB applications?
>
>  
>
>>I /do/ thank you for the interface-reset tip, though, I hope I never need 
>>that info  : )
>>    
>>
>
>It can be useful for recovering from a spun-down disk that won't spin
>up again :-)
>
>John
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>



