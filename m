Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263497AbTH0Rgf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 13:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263552AbTH0Rgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 13:36:35 -0400
Received: from mxrelay.osnanet.de ([212.95.97.103]:40406 "EHLO
	mxrelay.osnanet.de") by vger.kernel.org with ESMTP id S263497AbTH0Rgb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 13:36:31 -0400
Message-ID: <3F4CEB65.2080509@lilymarleen.de>
Date: Wed, 27 Aug 2003 19:33:25 +0200
From: LGW <large@lilymarleen.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030711 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: porting driver to 2.6, still unknown relocs... :(
References: <3F4CB452.2060207@lilymarleen.de> <20030827081312.7563d8f9.rddunlap@osdl.org> <3F4CCF85.1020502@lilymarleen.de> <1061999977.22825.71.camel@dhcp23.swansea.linux.org.uk> <20030827100745.0d944f33.shemminger@osdl.org> <Pine.LNX.4.53.0308271319350.2174@chaos>
In-Reply-To: <Pine.LNX.4.53.0308271319350.2174@chaos>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

>On Wed, 27 Aug 2003, Stephen Hemminger wrote:
>
>  
>
>>On 27 Aug 2003 16:59:38 +0100
>>Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>>
>>    
>>
>>>On Mer, 2003-08-27 at 16:34, LGW wrote:
>>>      
>>>
>>>>The driver is mostly a wrapper around a generic driver released by the
>>>>manufacturer, and that's written in C++. But it worked like this for the
>>>>2.4.x kernel series, so I think it has something todo with the new
>>>>module loader code. Possibly ld misses something when linking the object
>>>>specific stuff like constructors?
>>>>        
>>>>
>>>The new module loader is kernel side, it may well not know some of the
>>>C++ specific relocation types.
>>>      
>>>
>>You did something that was explicitly not supported on 2.4 and it worked,
>>it broke on 2.6.
>>
>>The fact that it worked it all on 2.4 was a fluke.
>>
>>It's time to breakdown, do the right thing and figure out how to rewrite/translate the
>>C++ code to C.
>>
>>    
>>
>
>  
>
>>You did something that was explicitly not supported on 2.4 and it worked,
>>    
>>
>                             ^^^^^^^^^^^^^^^^^^^^^^^^_______ Yes!
>
>There was lots of discussion/flames back-and-forth with newbies
>requiring that modules be written in C++.  This is what you get.
>Some of the C++ built-ins are not even global so the linker
>won't be able to find them if they are used. It's not just
>a matter of emulating 'new'. Parameter-passing 'by reference' also
>won't work so putting 'C' wrappers around stuff like they do
>in Dr. Jobbs and C/C++ Journal isn't going to work inside
>the kernel where there is no support.
>  
>
I absolutly agree with your opinion here. But due to the fact that the 
driver sources from the manufacturer where c++, a wrapper was easier 
(and the license of the driver is... restrictive I'm afraid...). But a 
rewrite in C is only a matter of time!

anyway, I have sound again, that's enough for the next few weeks I think.

regards,
  Lars

