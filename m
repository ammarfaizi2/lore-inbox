Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267678AbRGPTZ7>; Mon, 16 Jul 2001 15:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267682AbRGPTZt>; Mon, 16 Jul 2001 15:25:49 -0400
Received: from entropy.muc.muohio.edu ([134.53.213.10]:17282 "EHLO
	entropy.muc.muohio.edu") by vger.kernel.org with ESMTP
	id <S267678AbRGPTZh>; Mon, 16 Jul 2001 15:25:37 -0400
Date: Mon, 16 Jul 2001 15:25:29 -0400 (EDT)
From: George <greerga@entropy.muc.muohio.edu>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
cc: Marko Rebrina <mrebrina@jagor.srce.hr>, <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM:blinking screen in XFree4.x !
In-Reply-To: <Pine.LNX.4.33.0107161128050.579-100000@desktop>
Message-ID: <Pine.LNX.4.33.0107161519570.7876-100000@entropy.muc.muohio.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jul 2001, Jeffrey W. Baker wrote:

>On Mon, 16 Jul 2001, Marko Rebrina wrote:
>
>> Hi,
>> I have problem with XFree4.x(current 4.1) when I have large file transfer(~1GB)
>> then screen in X start blinking(black screen),console works fine!
>> Restarting Xe not resolving problem! No message in log !
>
>I used to have this problem as well.  It is due to massive clock skew on
>certain motherboads (ahem).  To "fix" this, simply display DPMS in your X
>server: xset -dpms

Running the XFree86 config program from XFree86-xf86cfg-4.0.3-5.i386.rpm
(RedHat 7.1) _causes_ the massive clock skew on my Tyan Tomcat IV (i430HX)
Pentium 233/MMX motherboard w/ S3 Virge.  My 2.2.19 kernel prints the
"clock skew detected -- probably a VIA 686a" message and resets the clock.
The NTP daemon afterward can't correct the clock fast enough if the kernel
doesn't fix it.  I can tell when it happens because the GPM mouse cursor
moves very jerky. If I don't run that program, no clock skew ever.
XFree86 4.0 is fine otherwise but since I can't screenshot with my BTTV
card, I run 3.3.6.

So maybe not always hardware, sometimes just suid apps stomping on what
they shouldn't.

-George Greer

