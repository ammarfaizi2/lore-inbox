Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262306AbVCPJnk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbVCPJnk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 04:43:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVCPJnk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 04:43:40 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:25348 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262306AbVCPJnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 04:43:37 -0500
Message-ID: <42380094.2050704@aitel.hist.no>
Date: Wed, 16 Mar 2005 10:47:00 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Andrew Morton <akpm@osdl.org>, dtor_core@ameritech.net,
       dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm3 mouse oddity
References: <20050312034222.12a264c4.akpm@osdl.org> <4236D428.4080403@aitel.hist.no> <d120d50005031506252c64b5d2@mail.gmail.com> <20050315110146.4b0c5431.akpm@osdl.org> <20050315201038.GA5484@ucw.cz>
In-Reply-To: <20050315201038.GA5484@ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:

>On Tue, Mar 15, 2005 at 11:01:46AM -0800, Andrew Morton wrote:
>  
>
>>Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>>    
>>
>>>On Tue, 15 Mar 2005 13:25:12 +0100, Helge Hafting
>>><helge.hafting@aitel.hist.no> wrote:
>>>      
>>>
>>>>2.6.11-mm1 and earlier: mouse appear as /dev/input/mouse0
>>>>2.6.11-mm3: mouse appear as /dev/input/mouse1
>>>>
>>>>No big problem, one change to xorg.conf and I got the mouse back.
>>>>I guess it wasn't supposed to change like that though?
>>>>
>>>>        
>>>>
>>>Vojtech activated scroll handling in keyboard code by default so now
>>>your keyboard is mapped to the mouse0 and the mouse moved to mouse1.
>>>      
>>>
>>We cannot ship a kernel with this change, surely?  Our users would come
>>hunting for us with pitchforks.
>>    
>>
>
>Mouse device numbers are defined to be unstable because of hotplug.
>
>Most users use /dev/input/mice, where this won't have impact.
>
>The officially correct solution is to use udev to get stable device
>names.
>
>The change is easily reverted - just change the 'atkbd.scroll' default
>value.
>  
>
Please don't remove it - it is nice to have support for the hardware.
Apps using this is also necessary - and they are possible now.
If you want to go the route of least surprise you may want to
make sure the "new" mice get higher numbers instead of
pushing "older" mice around.

Helge Hafting


