Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbUAFKLt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 05:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbUAFKLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 05:11:49 -0500
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:27918 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S261812AbUAFKLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 05:11:47 -0500
Message-ID: <3FFA8AEE.5090007@kolumbus.fi>
Date: Tue, 06 Jan 2004 12:16:14 +0200
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@colin2.muc.de>
CC: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>,
       David Hinds <dhinds@sonic.net>, linux-kernel@vger.kernel.org
Subject: Re: PCI memory allocation bug with CONFIG_HIGHMEM
References: <1aJdi-7TH-25@gated-at.bofh.it> <m37k054uqu.fsf@averell.firstfloor.org> <Pine.LNX.4.58.0401051937510.2653@home.osdl.org> <20040106040546.GA77287@colin2.muc.de> <Pine.LNX.4.58.0401052100380.2653@home.osdl.org> <20040106081203.GA44540@colin2.muc.de> <3FFA7BB9.1030803@kolumbus.fi> <20040106094442.GB44540@colin2.muc.de>
In-Reply-To: <20040106094442.GB44540@colin2.muc.de>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 06.01.2004 12:13:53,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 06.01.2004 12:13:01,
	Serialize complete at 06.01.2004 12:13:01
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Andi Kleen wrote:

>On Tue, Jan 06, 2004 at 11:11:21AM +0200, Mika Penttil? wrote:
>  
>
>>Andi Kleen wrote:
>>
>>    
>>
>>>>If you ahve a proper e820 map, then it should work correctly, with 
>>>>anything that is RAM being marked as such (or being marked as "reserved").
>>>>  
>>>>
>>>>        
>>>>
>>>Every e820 map i've seen did not have the AGP aperture marked reserved.
>>>
>>>      
>>>
>>Why should it? It's not ram, and the aperture is marked as reserved 
>>while doing PCI resource assignment/reservation.
>>    
>>
>
>It implies that you cannot just put your IO mappings
>into any holes. Because something else like the aperture may 
>be already there.
>

But AGP aperture is controlled with the standard APBASE pci base 
register, so you always know where it is, can relocate it and reserve 
address space for it. Of course there may exist other uncontrollable hw, 
which may cause problems.

>
>In my opinion it would have been cleaner if the aperture had always
>an reserved entry in the e820 map. Or better all usable holes get
>an special entry. Then you could actually reliable allocate IO space
> on your own. Currently it's just impossible.
>
>-Andi
>  
>
--Mika


