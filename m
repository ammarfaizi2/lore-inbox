Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269102AbUIHLE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269102AbUIHLE4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 07:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269103AbUIHLEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 07:04:55 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:38161 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S269102AbUIHLEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 07:04:40 -0400
Message-ID: <413EE857.7000102@hist.no>
Date: Wed, 08 Sep 2004 13:09:11 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Keith Whitwell <keith@tungstengraphics.com>,
       Dave Jones <davej@redhat.com>, Christoph Hellwig <hch@infradead.org>,
       Dave Airlie <airlied@linux.ie>, Jon Smirl <jonsmirl@yahoo.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mharris@redhat.com
Subject: Re: New proposed DRM interface design
References: <20040904102914.B13149@infradead.org>	 <4139FEB4.3080303@tungstengraphics.com>	 <9e473391040904110354ba2593@mail.gmail.com>	 <1094386050.1081.33.camel@localhost.localdomain>	 <9e47339104090508052850b649@mail.gmail.com>	 <1094393713.1264.7.camel@localhost.localdomain>	 <9e473391040905083326707923@mail.gmail.com>	 <1094395462.1271.12.camel@localhost.localdomain>	 <9e47339104090509056e54866e@mail.gmail.com> <413D74A5.3070002@hist.no> <9e47339104090707045d009de6@mail.gmail.com>
In-Reply-To: <9e47339104090707045d009de6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:

>On Tue, 07 Sep 2004 10:43:17 +0200, Helge Hafting <helge.hafting@hist.no> wrote:
>  
>
>>Jon Smirl wrote:
>>    
>>
>>>I would also like to fix things so that we can have two logged in
>>>users, one on each head. This isn't going to work if one them uses
>>>fbdev and keeps swithing the chip to 2D mode while the other user is
>>>in 3D mode. The chip needs to stay in 3D mode with the CP running.
>>>
>>>      
>>>
>>Yes!  I use the ruby patch and have two users logged in on the
>>two heads of a G550.  It works fine - as long as no mode
>>change is attempted.  And only one user can use 3D (or even 2D),
>>the other is stuck with a unaccelerated framebuffer.
>>    
>>
>
>There is nothing in the hardware preventing both users from having 3D
>displays. This is a problem in the way fbdev and DRM are designed. I
>would like to work towards fixing this.
>  
>
I have heard of someone using two 3D displays, but he
used separate cards.  Can you get this on a single G550, which
supports two monitors but don't duplicate all hardware?

I have tried running two 2D-drivers, that works. But running
even one 3D app then froze 2D on the other display until
the 3D action ended. Simultaneous 3D was impossible, the
second user got segfaults when 3D was "busy" on the first display.

Helge Hafting

