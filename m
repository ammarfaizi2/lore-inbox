Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264356AbRFTMZ2>; Wed, 20 Jun 2001 08:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264840AbRFTMZS>; Wed, 20 Jun 2001 08:25:18 -0400
Received: from ip65.levi.spb.ru ([212.119.175.65]:47335 "EHLO
	germes.levi.spb.ru") by vger.kernel.org with ESMTP
	id <S264356AbRFTMZM>; Wed, 20 Jun 2001 08:25:12 -0400
Message-ID: <3B3095FB.2060706@levi.spb.ru>
Date: Wed, 20 Jun 2001 16:24:27 +0400
From: Anatoly Ivanov <avi@levi.spb.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.1+) Gecko/20010619
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Kissandrakis S. George" <kissand@phaistosnetworks.gr>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5 and gcc v3 final
In-Reply-To: <3B30910F.6EDCC7A1@phaistosnetworks.gr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Solution is simple:
change line 540 from "extern struct timeval xtime;"
to "extern volatile struct timeval xtime;"
and have fun :)

---
avi

Kissandrakis S. George wrote:

> Hello
> I suppose that you allready know it
> I have installed gcc v3 released Jun 18 and i tried to compile the
> kernel and i got
> these errors
> 
> in make dep i got several warnings that look like this
> 
> /usr/src/linux-2.4.5/include/asm/checksum.h:161:17: warning: multi-line
> string literals are deprecated
> 
> but finally passed..
> 
> in make bzImage i got
> 
> timer.c:35: conflicting types for `xtime'
> /usr/src/linux-2.4.5/include/linux/sched.h:540: previous declaration of
> `xtime'
> 
> and compilation stops
> if i remove the decleration of xtime in sched.h (remove the 540 line)
> the compile
> will go on and some compiles after...
> 
> time.c: In function `do_normal_gettime':
> time.c:41: `xtime' undeclared (first use in this function)
> 
> and some other errors
> if in time.c include the line 540 from sched.h (the xtime) the
> compilation will go on
> until the same error on another file
> i include again the line 540 from sched.h the compilation goes on etc
> etc and after lots
> of errors finally i got bzImage
> 
> I didnt test bzImage if it boots 
> 
> with gcc v2.x the same kernel and kernel config it compiles,Is it a
> kernel bug, a gcc
> bug or something else (bad installation of gcc, my mistake etc etc)? 
> 
> Best Regards
> 
> 
> --- 
> Kissandrakis S. George                 [kissand@phaistosnetworks.gr]
> Network and System Administrator       [http://www.phaistosnetworks.gr/]
> Tel:(+30 81) 391882/Fax:(+30 892) 23206
> Phaistos Networks S.A. - A DOL Digital Company
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



