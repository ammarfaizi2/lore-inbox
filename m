Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279464AbRJ2UbM>; Mon, 29 Oct 2001 15:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279461AbRJ2Uaw>; Mon, 29 Oct 2001 15:30:52 -0500
Received: from freeside.toyota.com ([63.87.74.7]:59912 "EHLO toyota.com")
	by vger.kernel.org with ESMTP id <S279460AbRJ2Uan>;
	Mon, 29 Oct 2001 15:30:43 -0500
Message-ID: <3BDDBC90.7E16E492@lexus.com>
Date: Mon, 29 Oct 2001 12:31:12 -0800
From: J Sloan <jjs@lexus.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Nasty suprise with uptime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

This weekend I checked our mail/dns servers (on kernel 2.2.17-pre4)
and received a nasty surprise. The uptime, which had been 496+ days
on Friday, was back down to a few hours. I was ready to lart somebody
with great vigor when I realized the uptime counter had simply wrapped
around.

So, I thought to myself, at least the 2.4 kernels on our new boxes won't

have that silly, irritating limitation - or will they?

I checked include/linux/kernel.h on my workstation, which is running
2.4.14-pre3, and found that the uptime field in struct sysinfo is
exactly
the same as that in the 2.2. kernel on the mailservers, e.g.

--- snip ---
struct sysinfo {
        long uptime;                    /* Seconds since boot */
--- snip ---

Say it ain't so! maybe I'm a bit dense, but is the 2.4 kernel also going

to wrap around after 497 days uptime? I'd be glad if someone would
point out the error in my understanding.

Thanks,

jjs


