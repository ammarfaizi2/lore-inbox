Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272341AbTHEBxr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 21:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272342AbTHEBxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 21:53:47 -0400
Received: from user-0cal2fl.cable.mindspring.com ([24.170.137.245]:18182 "EHLO
	bender.davehollis.com") by vger.kernel.org with ESMTP
	id S272341AbTHEBxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 21:53:45 -0400
Message-ID: <3F2F0EEF.3080705@davehollis.com>
Date: Mon, 04 Aug 2003 21:57:03 -0400
From: David T Hollis <dhollis@davehollis.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: USB Mouse oddity with 2.6.0-test2-mm4 + 013int
References: <3F2ED292.2040302@davehollis.com> <20030805004552.GA17205@kroah.com>
In-Reply-To: <20030805004552.GA17205@kroah.com>
X-Enigmail-Version: 0.76.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:

>On Mon, Aug 04, 2003 at 05:39:30PM -0400, David T Hollis wrote:
>  
>
>>I just went to 2.6.0-test2-mm4 with Con's 012/013 interactivity patches 
>>(from 2.6.0-test2-mm2) on my laptop and I'm now having an odd time with 
>>my USB mouse.  After a short period of time (5 minutes or less), it 
>>stops working entirely.  If I remove the usbmouse module and reload it, 
>>I get it back.  There is nothing in my logs or dmesg output stating any 
>>kind of problem.  Is anyone else seeing this problem?  Anyone happen to 
>>know where the problem may lie?
>>    
>>
>
>Don't use the usbmouse module, use the hid module instead.
>
>But that should not really cause this problem.  Can you enable
>CONFIG_USB_DEBUG to see if anything else shows up in your logs?
>
>Oh, and does this also happen with 2.6.0-test2?
>
>thanks,
>
>greg k-h
>  
>
It worked fine under 2.6.0-test2-mm2 and 2.6.0-test2-mm1.   With some 
further investigating, it seems that usbmouse is not loaded at startup, 
just hid.  Following your suggestion, I removed both and just loaded hid 
and the mouse works ok, for a short period of time.  Eventually it stops 
and I have to rmmod hid and reload load it.   Sometimes I get a decent 
amount of time (maybe 30 minutes or so) before it sticks.  I'm turning 
on USB_DEBUG and will rebuild to see if I get any more helpful info.

