Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751756AbWJMSlD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbWJMSlD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 14:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbWJMSlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 14:41:02 -0400
Received: from bay0-omc2-s17.bay0.hotmail.com ([65.54.246.153]:6502 "EHLO
	bay0-omc2-s17.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1751756AbWJMSlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 14:41:00 -0400
Message-ID: <BAY20-F14CE177ABD2A134BD19ABAD80A0@phx.gbl>
X-Originating-IP: [80.178.105.199]
X-Originating-Email: [yan_952@hotmail.com]
In-Reply-To: <1160756702.14815.1.camel@laptopd505.fenrus.org>
From: "Burman Yan" <yan_952@hotmail.com>
To: arjan@infradead.org
Cc: davej@redhat.com, jesper.juhl@gmail.com, linux-kernel@vger.kernel.org,
       pazke@donpac.ru
Subject: Re: [PATCH] HP mobile data protection system driver
Date: Fri, 13 Oct 2006 20:40:57 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 13 Oct 2006 18:41:00.0415 (UTC) FILETIME=[20F8D8F0:01C6EEF7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




>From: Arjan van de Ven <arjan@infradead.org>
>To: Burman Yan <yan_952@hotmail.com>
>CC: davej@redhat.com, jesper.juhl@gmail.com, linux-kernel@vger.kernel.org,  
>pazke@donpac.ru
>
>well.... breaking stuff for no reason other than "but it sounds like HIS
>name" is I thing bad. Yes the name is unfortunate, but if you can use
>the interface... why not? Just because the name isn't perfect everyone
>should change over, including keeping compatibility mess etc etc?
>That needs a stronger reason than "it sounds like his name" to me...
>
>Now if the interface itself isn't good enough, that's a different matter
>of course; but from what I read so far that's not really the case.
>

You have a point, but the thing is that I hope to make this work interrupt 
driven in the future.
Right now for some reason request_irq fails with ENOSYS (I don't know if 
it's a bios acpi bug, or my bug
or acpi parsing bug yet, although I see that I get the right IRQ - the same 
as that other a bit less
known OS...;) and also request_irq succeeds on xen kernel, but fails on RH 
2.6.17.13 and vanilla 2.6.18).
To make a long story short, the interface should probably be different from 
hdaps'
in the future + hdapsd will have to be modified anyway since I cannot 
provide the functionality
to detect keyboard and mouse activity through the accelerometer, since it 
doesn't support it.

Right now I can emulate hdaps and perhaps I can even provide the same 
methods that will return
dummy result for the stuff I don't have. You think I should emulate hdaps' 
functionalty
that is missing from mdps? I actually didn't look at why hdapsd needs 
keyboard and mouse activity for.
I'm guessing that it's to see if you're using your laptop, since if there is 
activity, chances are
that your laptop is not falling and if it is, it's falling with you along... 
Need to check.

Regards
Yan

_________________________________________________________________
Don't just search. Find. Check out the new MSN Search! 
http://search.msn.click-url.com/go/onm00200636ave/direct/01/

