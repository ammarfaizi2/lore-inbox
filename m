Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130884AbRBES7S>; Mon, 5 Feb 2001 13:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131368AbRBES7I>; Mon, 5 Feb 2001 13:59:08 -0500
Received: from mail2.mia.bellsouth.net ([205.152.144.14]:36524 "EHLO
	mail2.mia.bellsouth.net") by vger.kernel.org with ESMTP
	id <S130884AbRBES7D>; Mon, 5 Feb 2001 13:59:03 -0500
Message-ID: <3A7EF830.50805@bellsouth.net>
Date: Mon, 05 Feb 2001 14:00:00 -0500
From: Louis Garcia <louisg00@bellsouth.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.1-3 i686; en-US; 0.7) Gecko/20010202
X-Accept-Language: en
MIME-Version: 1.0
To: Bakonyi Ferenc <fero@drama.obuda.kando.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: nvidia fb 0.9.0 (0.9.2?)
In-Reply-To: <E14PotN-0002qZ-00@aleph0.datakart.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bakonyi Ferenc wrote:

> Louis Garcia <louisg00@bellsouth.net> wrote:
> 
>> I gave upgraded to 2.4.2pre on my RH7 box and while using riva-128 fb 
>> noticed when in X all the white parts of my desktop are to dark, it is 
>> almost unreadable. I think it might have to do with video timing, is 
>> there a way to fix this?
> 
> 
> 	Hi!
> 
> Color handling on Riva 128 in 8bpp mode is a little bit confused.
> The table below summarizes the depth of color registers in 8bpp mode:
> 
>                 | Riva 128 | Riva TNT and higher
> ----------------+----------+--------------------
> XF86            | 6 bit    | 8 bit
> ----------------+----------+--------------------
> rivafb < 0.7.2  | 6 bit    | 6 bit 'dark console'
> ----------------+----------+--------------------
> rivafb 0.7.3    | 6 bit    | 8 bit
> ----------------+----------+--------------------
> rivafb 0.9.2    | 8 bit    | 8 bit
> ----------------+----------+--------------------
> 
> The Riva hardware can be programmed to expect 8 bit or 6 bit color 
> registers. Rivafb < 0.7.2 used 6 bit color registers, but the hw was 
> programmed to 8 bit registers on TNT/TNT2. That was causing the so 
> called 'dark console' bug.
> Rivafb 0.9.2 begins to utilize 8 bits on Riva 128, but your X server 
> uses only 6 bits of them so your desktop's brightness is 1/4. Now 
> Riva 128 has a 'dark X' bug. :)
> The X server should be patched. Which X server/version are you using?
> 
> Regards:
> 	Ferenc Bakonyi
> 
> 
> 
> 
I'm using XFree86-4.0.1 with the nv driver. You are right, it's ver 
0.9.2 for the fb.

Where can I get the patch? Should I upgrade to XFree86-4.0.2?

Lou

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
