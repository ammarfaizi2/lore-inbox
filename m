Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263553AbTH0QVo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 12:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263474AbTH0QTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 12:19:47 -0400
Received: from mxrelay.osnanet.de ([212.95.97.103]:44485 "EHLO
	mxrelay.osnanet.de") by vger.kernel.org with ESMTP id S263435AbTH0QS5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 12:18:57 -0400
Message-ID: <3F4CD937.10204@lilymarleen.de>
Date: Wed, 27 Aug 2003 18:15:51 +0200
From: LGW <large@lilymarleen.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030711 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: porting driver to 2.6, still unknown relocs... :(
References: <3F4CB452.2060207@lilymarleen.de>	 <20030827081312.7563d8f9.rddunlap@osdl.org>	 <3F4CCF85.1020502@lilymarleen.de> <1061999977.22825.71.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1061999977.22825.71.camel@dhcp23.swansea.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Mer, 2003-08-27 at 16:34, LGW wrote:
>  
>
>>The driver is mostly a wrapper around a generic driver released by the 
>>manufacturer, and that's written in C++. But it worked like this for the 
>>2.4.x kernel series, so I think it has something todo with the new 
>>module loader code. Possibly ld misses something when linking the object 
>>specific stuff like constructors?
>>    
>>
>
>The new module loader is kernel side, it may well not know some of the
>C++ specific relocation types. 
>
To you think it's possible to remove those relocations completely, so 
that the whole C++ stuff is linked "without" any more open relocations?

After all, those are only "helper functions" that could be linked 
"statically", or am I mistaken?

I don't have such deep knowledge of the C++ linking process, so I can't 
answer that question myself.

The Generic Driver is not public available I think, but you could get it 
here:
http://space.virgilio.it/g_pochini@virgilio.it/ea.html (site with the 
patches for alsa)
http://space.virgilio.it/g_pochini@virgilio.it/eagd-0.6.0.tar.bz2 (the 
original generic driver code)

thanks,
  Lars


