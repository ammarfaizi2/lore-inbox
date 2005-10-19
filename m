Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbVJSShA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbVJSShA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 14:37:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751212AbVJSSg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 14:36:59 -0400
Received: from smtpout.mac.com ([17.250.248.85]:41210 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751213AbVJSSg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 14:36:58 -0400
In-Reply-To: <1129745264.25383.36.camel@gnupooh.mitre.org>
References: <1129741246.25383.23.camel@gnupooh.mitre.org> <4C7CA605-435C-4B16-A3A1-44EF247BF5B0@mac.com> <1129745264.25383.36.camel@gnupooh.mitre.org>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AACE0A4B-1D25-490A-860D-3C8B526D755F@mac.com>
Cc: LKML Kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: 26 ways to set a device driver variable from userland
Date: Wed, 19 Oct 2005 14:36:49 -0400
To: Rick Niles <fniles@mitre.org>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm CCing this to the LKML, because it's useful to the list in  
general and you're much more likely to get useful replies as well.

On Oct 19, 2005, at 14:07:44, Rick Niles wrote:
> I really appreciate the prompt and complete feedback.  While you're  
> at it perhaps you can answer another one for me.

Please don't top-post :-D.  Thanks!
http://www.zipworld.com.au/~akpm/linux/patches/stuff/top-posting.txt
http://catb.org/~esr/jargon/html/T/top-post.html

> I'm doing a low-level GPS receiver driver. This is NOT a serial  
> port kinda thing.  I have to close tracking loops and that sort of  
> thing at faster that 1ms.  I was planning on outputing the actual  
> tracking data (not the parameters I asked about earlier) through a  
> read of a device file.   However, your point about binary  
> structures applied to this as well.  Would you say I should not use  
> a device file at all?  Should the device file output ASCII instead  
> of binary (this brings up an eff. argument)
>
> Also, each GPS satellite transmits a standard binary data message  
> that I definitely should not mess with in the kernel (IMHO).   
> However, the GPS range is computed using the settings of the  
> oscillator and some counters off the correlator chip.  I planned on  
> making each channel a separate
> device file. Would it be OK to mix this GPS data message with the  
> corellator tracking information, or should I make two files?  Or  
> perhaps, depending on your answer to above you might say the  
> tracking info should be in sysfs.

Umm, hmm.  This really depends on a bunch of stuff I don't really  
understand all that well, but I'll try :-D.  The simplest way to do  
it would be to just stick each distinct value in a sysfs file and let  
your GPS software read each one and do what it wants from them.  That  
would make it really easy to shell-script with GPS coordinates too :- 
D.  Others on the list may have more informative/useful responses  
here, sorry!

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.  The first method is far more difficult.
   -- C.A.R. Hoare


