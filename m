Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280190AbRL1V4T>; Fri, 28 Dec 2001 16:56:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280426AbRL1V4J>; Fri, 28 Dec 2001 16:56:09 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6925 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280190AbRL1Vz7>; Fri, 28 Dec 2001 16:55:59 -0500
Message-ID: <3C2CEA54.5050907@zytor.com>
Date: Fri, 28 Dec 2001 13:55:32 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: zImage not supported for 2.2.20?
In-Reply-To: <UTC200112282106.VAA133464.aeb@cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:

> 
> I my A20 writeup (http://www.win.tue.nl/~aeb/linux/kbd/A20.html) I wrote:
> 
> ------------------------------------------------------------------------
> Jens Maurer reported in 1996 on boot problems with a bzImage kernel: 
> 
>     On the Toshiba laptop, the first two bytes at 0x100000 are incorrect
>     and identical to those from address 0x000000 (which was an alias for
>     0x100000 before the A20 gate enable). At a second read from 0x100000
>     immediately afterwards, the correct memory content is returned.
>     Asus P55TP5XE boards (Triton I chipset) show quite the same problem,
>     but there, only the first byte is incorrect and booting bzImage kernels
>     works fine. To me, this looks like some buffer or cache coherency
>     problem although I think that caches are organized in at least 16
>     byte cache lines. ... This exact same problem reportedly also exists
>     on Fujitsu 555T (report from Andrea Caltroni) laptop and Compudyne
>     Pentium 60 (report from David Kerr) desktop computers. 
> 
> He gives a patch, and adds "Unfortunately, Philip Hands reports that
> the above patch makes some people with other non-laptop computers unable
> to boot." 
> 
> Using zImage instead of bzImage avoids the problem (since zImage is not
> loaded high). Debian has distributed special Tecra boot floppies for a while.
> Later it was found out that these laptops just have an incredibly slow
> keyboard controller and that all is fine with a larger timeout. 
> ------------------------------------------------------------------------
> 
> Is this inaccurate?
> 


No, it's consistent with my information; the point is that the 
workaround for these laptops have existed for a long time... the timeout 
applied in current kernels is positively glacial.

	-hpa


