Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbTLMJRj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Dec 2003 04:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbTLMJRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Dec 2003 04:17:38 -0500
Received: from xavier.comcen.com.au ([203.23.236.73]:62472 "EHLO
	xavier.etalk.net.au") by vger.kernel.org with ESMTP id S264535AbTLMJRg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Dec 2003 04:17:36 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: linux-kernel@vger.kernel.org
Subject: Re: Working nforce2, was Re: Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
Date: Sat, 13 Dec 2003 19:20:57 +1000
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312131920.57880.ross@datscreative.com.au>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>
>>I decided to wait till this morning, to try the BIOS "C1 Disconnect" set to
>> enabled. Still no lockups under this kernel. Tried a vanilla kernel, no
>> lockups (but timer and watchdog messed up still). Now that I read
>> your message Bob, I understand what you are saying. Luckily, the 
>>updated BIOS changelog states "Add C1 disconnect item." And this exact
>> version seems to have fixed it, and now we have an exact fix (another one?) 
>>to refer to. 
> > 
> >So the fix was absolutely a BIOS fix. 
> > 
<snip>

==That's why I'm trying to contact shuttle.
Jesse

Good Work Jesse, I hope shuttle give up some info - especially as I have
pheonix bioses and they are doing ?? about it?


> ...but we're stuck looking at smoke and mirrors, 
> when the kernel might be able to work around 
> bioses that have not been "updated". Or to put 
> it another way, "voodoo" may be done by 
> kernel if not done by bios. Whatever is being 
> tweaked may be accessible to kernel code. 
<snip>
Bob

Please ignore the following if you are already up to speed on SMM. Some
readers may not know why we cannot do all that the bios can do aside from
a lack of information.
 
Agreed but the keywords are might and may. I remember doing dos based data acquisition 
with 486SX laptops and then Intel brought out the 486Sl and our pulse counting 
went bad because of the power saving core. I got the data book from Intel and
was very dismayed to see that bios code was being executed when I thought our code
was running and there was not a darn thing I could do about it and keep the
laptop warranty intact. 

Its offspring as you may already know is SMM. It is a priviledged mode that we can
do pretty much squat about. It can pop up anywhere in the middle of our code 
and the only thing we will know about it aside from missing time is when it has
stuffed something up - like setting registers back to the wrong values. Think of
it like a kernel within our kernel with permissions set so it can hack us but we
cannot hack it.

Maciej recently writes of its continuing effect on NMI debug here.

http://linux.derkeiler.com/Mailing-Lists/Kernel/2003-12/2940.html

Regards
Ross.

