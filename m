Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbRAONCf>; Mon, 15 Jan 2001 08:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129998AbRAONCZ>; Mon, 15 Jan 2001 08:02:25 -0500
Received: from alex.intersurf.net ([216.115.129.11]:61710 "HELO
	alex.intersurf.net") by vger.kernel.org with SMTP
	id <S129664AbRAONCM>; Mon, 15 Jan 2001 08:02:12 -0500
Message-ID: <XFMail.20010115070211.markorr@intersurf.com>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.21.0101150318000.12760-100000@freak.distro.conectiva>
Date: Mon, 15 Jan 2001 07:02:11 -0600 (CST)
Reply-To: Mark Orr <markorr@intersurf.com>
From: Mark Orr <markorr@intersurf.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.0-ac9 works, but slower and swappier
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 15-Jan-2001 Marcelo Tosatti wrote:
> On Sun, 14 Jan 2001, Mark Orr wrote:
>> I've been running 2.4.0-ac9 for a day and a half now.
>> 
>> I have pretty low-end hardware (Pentium 1/ 100MHz, 16Mb RAM,
>> 17Mb swap)  and it really seems to bog down with anything
>> heavy in memory.    Netscape seems to really drag, and any
>> Java applets I encounter positively crawl -- you can see
>> the individual widgets being drawn.
> 
> Could you please try this patch:
> 
> http://bazar.conectiva.com.br/~marcelo/patches/v2.4/2.4.1pre3/try_to_free_page
> s-3.patch  > and report results?

Yeah, I just applied the patch and recompiled.  Yes, it fixed it, pretty
decisively too.

P100/16Mb RAM/17Mb swap -- run Netscape 3.04, and start some large Java
applet -- like a Java-based game or Yahoo Chat or some such.

...on 240-ac4, it works okay.   On 240-ac9, the disk grinds away, and it's
so slow you can see individual widgets being drawn.

With this patch, it's pretty much back to the way it was in -ac4, maybe a
little better.

thanx.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
