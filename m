Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264048AbUFKPSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264048AbUFKPSl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 11:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264054AbUFKPSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 11:18:41 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:15790 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S264048AbUFKPSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 11:18:18 -0400
Message-ID: <40C9CD38.2090501@enenet.com>
Date: Fri, 11 Jun 2004 11:18:16 -0400
From: Vadim Garber ENEnet <vadim@enenet.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040228)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: touchpad (PS/2) mouse detection problem.
References: <40C8EA4B.7070604@enenet.com> <MPG.1b33c0a163d6f2e59896ca@news.gmane.org>
In-Reply-To: <MPG.1b33c0a163d6f2e59896ca@news.gmane.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuseppe Bilotta wrote:

>Vadim Garber ENEnet wrote:
>  
>
>>Hello,
>>
>>I've compiled the 2.6.6 kernel, and I can't seem to get my laptops 
>>touchpad to get detected.
>>The touchpad runs on the ps/2 protocol; so it seems like there would be 
>>no problems with
>>detection. But of course I'm not a very lucky person ;-). The touchpad 
>>itself does have an
>>on/off botton; and I've made sure to keep it ON. This is a strange 
>>problem because I don't
>>seem to have it in older kernels (2.4.x). Cat'ing 
>>/proc/bus/input/devices also doesn't turn up
>>any useful information; just returns my keyboard (which works; yepi!). 
>>I've compiled
>>psmouse both into the kernel and as a module; both don't work.
>>
>>dmesg only shows "mice: PS/2 mouse device common for all mice" but no 
>>'input:' line.
>>    
>>
>
>More info on the laptop mfgr/series/model and the touchpad 
>type? Which input modules do you have, compiled in or as 
>modules?
>
>  
>
laptop: Compaq Presario 3190 (US), touchpad is an alps
ps/2 protocol pad, and I've compiled the psmouse as a
module (but I have also tried compiling it into the kernel).
I've also patched the kernel with the alps patch as directed.

 --- Userland interfaces
 --- Mouse interface
 (1024) Horizontal screen resolution
 (768) Vertical screen resolution
< > Joystick interface
 <M> Touchscreen interface
(240) Horizontal screen resolution
(320) Vertical screen resolution
<M> Event interface
< > Event debugging
--- Input I/O drivers
< > Gameport support
< > Serial port line discipline
< > ct82c710 Aux port controller
< > Parallel port keyboard adapter
< > PCI PS/2 keyboard and PS/2 mouse controller
--- Input Device Drivers
--- Keyboards
< >   Sun Type 4 and Type 5 keyboard support
< >   DECstation/VAXstation LK201/LK401 keyboard support
< >   XT Keyboard support
< >   Newton keyboard
[*] Mice
<M>   PS/2 mouse
< >   Serial mouse
< >   DEC VSXXX-AA/GA mouse and VSXXX-AB tablet
[ ] Joysticks
 [ ] Touchscreens
[ ] Misc

regards,

vadim

