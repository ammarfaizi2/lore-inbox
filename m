Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262305AbVCPJkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbVCPJkv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 04:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbVCPJkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 04:40:51 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:21508 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262305AbVCPJkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 04:40:41 -0500
Message-ID: <4237FFE4.4030100@aitel.hist.no>
Date: Wed, 16 Mar 2005 10:44:04 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: dtor_core@ameritech.net, dmitry.torokhov@gmail.com,
       linux-kernel@vger.kernel.org, vojtech@suse.cz
Subject: Re: 2.6.11-mm3 mouse oddity
References: <20050312034222.12a264c4.akpm@osdl.org>	<4236D428.4080403@aitel.hist.no>	<d120d50005031506252c64b5d2@mail.gmail.com> <20050315110146.4b0c5431.akpm@osdl.org>
In-Reply-To: <20050315110146.4b0c5431.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>  
>
>>On Tue, 15 Mar 2005 13:25:12 +0100, Helge Hafting
>><helge.hafting@aitel.hist.no> wrote:
>>    
>>
>>>2.6.11-mm1 and earlier: mouse appear as /dev/input/mouse0
>>>2.6.11-mm3: mouse appear as /dev/input/mouse1
>>>
>>>No big problem, one change to xorg.conf and I got the mouse back.
>>>I guess it wasn't supposed to change like that though?
>>>
>>>      
>>>
>>Vojtech activated scroll handling in keyboard code by default so now
>>your keyboard is mapped to the mouse0 and the mouse moved to mouse1.
>>    
>>
>
>We cannot ship a kernel with this change, surely?  Our users would come
>hunting for us with pitchforks.
>  
>
I like it, actually.  Now I have support for the wheels on this
logitech wireless keyboard.  Note that most users won't get
trouble, because they use /dev/mice.  Which is something
all single-head machines can do.

>  
>
>>Vojtech, is is possible to detect whether a keyboard has scroll
>>wheel(s) by its ID?
>>    
>>
>
>What sort of keyboard has a scroll wheel??
>
>  
>
The logitech cordless keyboard is one.  It has two wheels.
The one on the side works generates up-arrow/down arrow when used,
and now also events on /dev/mouse0.  The other is a wheel above
the keys, lying on the side.  Logitech apparently meant it to be used as
a volume control, which should be possible now that it attaches to
/dev/mouse0.

Note that /dev/mice isn't always the answer - dual seat machines
need to separate the various mice and keyboards.

Helge Hafting
