Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbVK1TNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbVK1TNe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 14:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbVK1TNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 14:13:34 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:6801 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932185AbVK1TNd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 14:13:33 -0500
Message-ID: <4384C524.8070202@tmr.com>
Date: Wed, 23 Nov 2005 14:38:12 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Antonino A. Daplas" <adaplas@gmail.com>
CC: Damien Wyart <damien.wyart@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: VESA fb console in 2.6.15
References: <20051121215531.GA3429@localhost.localdomain>	<43826648.9030606@gmail.com>	<87oe4c7gbv.fsf@brouette.noos.fr> <20051122162226.41305851.akpm@osdl.org> <4383B880.80301@gmail.com>
In-Reply-To: <4383B880.80301@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonino A. Daplas wrote:
> Andrew Morton wrote:
> 
>>Damien Wyart <damien.wyart@gmail.com> wrote:
>>
>>>>>I've noticed in several versions of 2.6.15 that VESA fb console
>>>>>seems completely broken : it draws screen in several very slow
>>>>>steps, making the whole display almos unusable. And it crashes
>>>>>*very* often, for example when switching to X. The computer is
>>>>>complety locked, and doesn't even respond to SysRQ.
>>>>>I use vga=0x31B as boot param.
>>>
>>>* "Antonino A. Daplas" <adaplas@gmail.com> [051122 01:28]:
>>>
>>>
>>>>Try booting with:
>>>>vga=0x31b video=vesafb:mtrr:3
>>>
>>>Thanks, this works fine with this param and also without any video=
>>>param. I had a default video=vesafb:mtrr:2 in my grub conf file because
>>>of mtrr problems a few kernel versions earlier (had been discussed
>>>extensively on this list). This setting doesn't work well in 2.6.15.
>>>
>>
>>Does 2.6.15-rc? work OK without any special boot options? (We want it to..)
>>
> 
> 
> From what I understand, before this, he needs video=vesafb:mtrr:2. (Because
> his machine defaults to write-back mtrr instead of write-combining). Now it
> works without any special boot options because I made vesafb default to
> nomtrr because of problems like this and conflicts with X/DRI.
> 
Thank you, I bet this fixes a problem I was having with a system which 
sometimes came up with video problems unless I used an mtrr parameter.
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

