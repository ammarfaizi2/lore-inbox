Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWGURQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWGURQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 13:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWGURQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 13:16:59 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.82]:50077 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1750772AbWGURQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 13:16:59 -0400
Message-ID: <44C10C08.5040007@cmu.edu>
Date: Fri, 21 Jul 2006 13:16:56 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.4 (X11/20060604)
MIME-Version: 1.0
To: Dmitry Torokhov <dtor@insightbb.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: thinkpad x60s: middle button doesn't work after hibernate
References: <44BFD911.70106@cmu.edu> <d120d5000607201246s6af0223o83be95ef54147f10@mail.gmail.com> <44C0EA85.30500@cmu.edu> <200607211300.17660.dtor@insightbb.com>
In-Reply-To: <200607211300.17660.dtor@insightbb.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dmitry Torokhov wrote:
> On Friday 21 July 2006 10:53, George Nychis wrote:
>> Dmitry Torokhov wrote:
>>> On 7/20/06, George Nychis <gnychis@cmu.edu> wrote:
>>>> Hey guys,
>>>>
>>>> I recently got the suspend to disk working and suspend to memory working
>>>> thanks to many of you.  Whenever I suspend to disk and resume, the
>>>> middle mouse button on my thinkpad x60s no longer works for scrolling or
>>>> for pasting.  I either have to reboot, or suspend to memory and resume.
>>>>  Therefore:
>>>>
>>>> Initial Boot: working
>>>> Suspend to disk -> resume: not working
>>>> Suspend to memory -> resume: working
>>>>
>>>> To fix it for now, i simply suspend to memory and resume after resuming
>>>> a suspend to disk.
>>>>
>>> It sounds like psmouse resume method either not getting called or
>>> fails during resume from disk. Could you do:
>>>
>>> echo 1 > /sys/modules/i8042/parameters/debug
>>>
>>> before suspending and send me dmesg after resuming. Make sure you have
>>> big dmesg buffer.
>>>
>>> Thanks!
>>>
>> Here it is:
>> http://rafb.net/paste/results/hDJXzS85.html
>>
>> thanks again :)
>>
> 
> Please try the patch below. If it still does not work try uncommenting call
> to psmouse_reset() in trackpoint_resume().
> 

The unmodified patch worked like a charm, thanks so much for your time.
work, and help Dmitry

- George
