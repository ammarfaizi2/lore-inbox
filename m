Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281156AbRKKX1A>; Sun, 11 Nov 2001 18:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281160AbRKKX0k>; Sun, 11 Nov 2001 18:26:40 -0500
Received: from mail1.amc.com.au ([203.15.175.2]:2308 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S281156AbRKKX0d>;
	Sun, 11 Nov 2001 18:26:33 -0500
Message-Id: <5.1.0.14.0.20011112101656.00a20630@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 12 Nov 2001 10:26:28 +1100
To: linux-kernel@vger.kernel.org
From: Stuart Young <sgy@amc.com.au>
Subject: Re: SiS630 and 5591/5592 AGP
Cc: Gavin Baker <gavbaker@ntlworld.com>
In-Reply-To: <20011111185930.A2700@box.penguin.power>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:59 PM 11/11/01 +0000, Gavin Baker wrote:
>My new laptop has this combination and the sis framebuffer driver
>mangles the display. The sis X driver produces a nice lavalamp style
>pattern that fades to white, the kernel stays alive but the machine
>needs a reboot to fix the display in both cases.
>
>Im guessing the lack of 5591/5592 AGP support is the problem, and I
>was just wondering if anyone is working on this or should i go bug SiS?

You've got the same problem I have. There is something weird with the way 
some laptops (and LCD based desktops) handle this display, and the only way 
I've gotten around it is to use the VesaFB driver (which is heaps slower 
than the accelerated driver), and then either use the FB driver for X 
(which is buggy IMHO, crashes if it gets too much to do buffered up), or 
disable the mode changes and use the SiS accelerated X driver.

Alan has new drivers in his ac tree. but I've tried them, and no luck. Give 
them a shot and see how you go. You might be lucky.

Out of interest, what model/manufacturer is the notebook? The machines I'm 
having problems with are Clevo LP200S's, which is an upright LCD machine, 
with the h/drive and power supply down in the stand/foot.

Once we get everything working with Linux, they'll suit the application we 
have for them rather nicely. *sigh*

Q: Slightly related, have you gotten the sound to work? Driver loads, I get 
"Unknown Codec" and an empty codec value. Reloading the driver makes no 
difference (even numerous times). Wondering if your system is the same...


AMC Enterprises P/L    - Stuart Young
First Floor            - Network and Systems Admin
3 Chesterville Rd      - sgy@amc.com.au
Cheltenham Vic 3192    - Ph:  (03) 9584-2700
http://www.amc.com.au/ - Fax: (03) 9584-2755

