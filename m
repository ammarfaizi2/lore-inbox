Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265396AbSKSOzo>; Tue, 19 Nov 2002 09:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbSKSOzo>; Tue, 19 Nov 2002 09:55:44 -0500
Received: from guru.webcon.net ([66.11.168.140]:46251 "EHLO guru.webcon.net")
	by vger.kernel.org with ESMTP id <S265396AbSKSOzm>;
	Tue, 19 Nov 2002 09:55:42 -0500
Date: Tue, 19 Nov 2002 10:02:42 -0500 (EST)
From: Ian Morgan <imorgan@webcon.net>
To: Zwane Mwaikambo <zwane@holomorphy.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: p4-clockmod doing the Right Thing[tm]?
In-Reply-To: <Pine.LNX.4.44.0211190909580.21575-100000@light.webcon.net>
Message-ID: <Pine.LNX.4.44.0211190948110.2942-100000@light.webcon.net>
Organization: "Webcon, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Nov 2002, Ian Morgan wrote:

> ... the p4-clockmod module loads OK. Thx.

OK.. this is strange, maybe.

# cat /proc/cpufreq
          minimum CPU frequency  -  maximum CPU frequency  -  policy
CPU  0       300685 kHz ( 12 %)  -    2405487 kHz (100 %)  -  performance

# cat /proc/sys/cpu/0/*
2405487
2405487
300685

# echo 300685 >proc/sys/cpu/0/speed
[box stalls for about 25-30 seconds]

# cat /proc/sys/cpu/0/*
300685
2405487
300685

# echo 2405487 >proc/sys/cpu/0/speed
[box stalls for about 25-30 seconds]

# cat /proc/sys/cpu/0/*
2706165
2405487
300685

# cat /proc/cpufreq
          minimum CPU frequency  -  maximum CPU frequency  -  policy
CPU  0     2405487 kHz ( 100 %)  -    2706165 kHz (112 %)  -  powersave


?!?! Should the P4 really be able to go to 112%, and why would it do that
after I told it to go back to 100% ?

Any idea why the box would stall (at least no kb/mouse input is accepted,
not sure about other interrupts) for such a long time when changing the
speed?

On the other hand, some short (<1 min) cpu-bound processes for benchmarking
each took the same amount of time to run when the clock was at 12%, 100%,
and 112%, so I'm not sure the clock was really being changed at all.

Regards,
Ian Morgan

-- 
-------------------------------------------------------------------
 Ian E. Morgan          Vice President & C.O.O.       Webcon, Inc.
 imorgan@webcon.ca          PGP: #2DA40D07           www.webcon.ca
    *  Customized Linux network solutions for your business  *
-------------------------------------------------------------------

