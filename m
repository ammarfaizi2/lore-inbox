Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135784AbRDYBBh>; Tue, 24 Apr 2001 21:01:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135783AbRDYBB2>; Tue, 24 Apr 2001 21:01:28 -0400
Received: from dfw-smtpout1.email.verio.net ([129.250.36.41]:48605 "EHLO
	dfw-smtpout1.email.verio.net") by vger.kernel.org with ESMTP
	id <S135780AbRDYBBL>; Tue, 24 Apr 2001 21:01:11 -0400
Message-ID: <3AE621D1.FE45602B@bigfoot.com>
Date: Tue, 24 Apr 2001 18:01:05 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19-intel-smp-ide i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Whit Blauvelt <whit@transpect.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 Realaudio masq problem
In-Reply-To: <20010424201403.A1909@free.transpect.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been running masquerading unchanged from 2.2.13, currently 2.2.19 as:

        real IP +
         masq.                 192.168.1.NNN
DSL <-> gateway <-> switch <-> client 1
        server             <-> client 2
                           ...
                           <-> client n

There was some general slowness over the last few days (Bay Area, California
<-> US East Coast) including realaudio being unable to locate servers and/or
content.  This one is working right now:

RealPlayer v 7.0.3.338

abit:~ > cat On24ram.asp
rtsp://rm.on24.com/media/news/04192001/palumbo_ted6.rm
--stop--
http://rm.on24.com/media/news/04192001/palumbo_ted6.rm

Try '# strace /usr/bin/X11/realplay On24ram.asp > log' and see where the
connect fails if you aren't getting specific error messages.

rgds,
tim.

Whit Blauvelt wrote:
> 
> The Release Notes say "Fix problems with realaudio masquerading". Looked
> promising, since with 2.2.17 one masqueraded system (but not another) was
> having occassional problems with realaudio at some (but not all) sites.
> 
> Compiled 2.2.19 with 'make oldconfig,' no to new options. Otherwise running
> with the same firewall and masquerading settings (and yes I built and
> installed ip_masq_raudio.o). Masquerading is otherwise working, but now
> neither masqueraded system can connect with realaudio - the realplay routine
> to find a way to make a connection automatically fails for both.

rgds,
tim.
--
