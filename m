Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRAIRce>; Tue, 9 Jan 2001 12:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129534AbRAIRcY>; Tue, 9 Jan 2001 12:32:24 -0500
Received: from law2-f66.hotmail.com ([216.32.181.66]:1547 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S129511AbRAIRcR>;
	Tue, 9 Jan 2001 12:32:17 -0500
X-Originating-IP: [208.5.125.50]
From: "Kambo Lohan" <kambo77@hotmail.com>
To: linux-kernel@vger.kernel.org, eepro100@scyld.com
Subject: Re: [eepro100] ...
Date: Tue, 09 Jan 2001 12:32:11 -0500
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <LAW2-F66OTNECfI6JA900000707@hotmail.com>
X-OriginalArrivalTime: 09 Jan 2001 17:32:11.0585 (UTC) FILETIME=[19472310:01C07A62]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>You could try the Intel driver (e100.c), which is downloadable from their 
>website. It apparently has some silicon bug workarounds that Donald's 
>driver hasn't.

We've been back and forth with that driver, yeah.  It has its own set of 
problems, sometimes it doesnt even autonegotiate properly, falls to 10 half 
duplex, etc.  It also seems to have gotten quite large code wise (code wise) 
in the latest version (1.3.x.something) :)    We dont need any of their 
ans/teaming/proc stuff, but it is stable on this particular problem.

Their driver doesnt even compile out of the box on 2.2.18 btw (intel e100.c 
1.3.2, latest I could find), _badudelay.  I had to change one call to 
mdelay, and comment out their dma_addr_t type because of the conflicting 
declaration.  Doesnt give me much confidence :(

>Also please note that such a subject line is not a good motivation to help 
>you for free.
>-Andi

Sorry.  It wasnt my subject though, I was replying to someone else and just 
put the 'Re:' in.  But I will be more careful...

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
