Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270736AbTGUV0T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 17:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270731AbTGUV0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 17:26:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51464 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S270729AbTGUVYc (ORCPT
	<rfc822;linux-kernel@vger.redhat.com>);
	Mon, 21 Jul 2003 17:24:32 -0400
Message-ID: <3F1C5F05.5030903@kolumbus.fi>
Date: Tue, 22 Jul 2003 00:45:41 +0300
From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: linux-kernel@vger.redhat.com
Subject: Re: swsusp / 2.6.0-test1
References: <1058805510.15585.7.camel@simulacron> <20030721193615.GB473@elf.ucw.cz> <3F1C5C26.10607@kolumbus.fi> <20030721213141.GF436@elf.ucw.cz>
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 22.07.2003 00:40:53,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 22.07.2003 00:40:22,
	Serialize complete at 22.07.2003 00:40:22
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Pavel Machek wrote:

>Hi!
>
>  
>
>>>>swsusp is working fine, but mplayer
>>>>in sdl and xv output mode displays a blank
>>>>screen after a resume. 
>>>>  
>>>>        
>>>>
>>>You probably need to write suspend/resume support for your card.
>>>
>>>      
>>>
>>Just wondering what kind of support for suspend/resume is "enough", say 
>>for video cards? Surely not the pci configuration space, you need to 
>>restore video mode, color maps, gfx engine state etc etc...what about 
>>frame buffer contents on card? Probably yes. Sounds like a lot of code, 
>>and different thing for every possible video card. Is there some general 
>>guidance here? Is drivers/video soon bloating with tons of 
>>suspend/resume code? I hope I am wrong :)
>>    
>>
>
>I'm not sure if you are wrong. If you switch  to non-graphics console,
>that may save some code, but...
>
>  
>
ah ok, so at this stage swsuspending a X desktop doesn't work in general 
case, of course depending on video hardware? If X had some notion of 
suspend/resume things would be easier, than insisting every single 
driver save and restore all. After all the pci config space should be 
enough for kernel drivers?



>BTW vger.redhat.com, what is that?
>								Pavel
>

Don't know, just did reply all and seems to work :)

--Mika


