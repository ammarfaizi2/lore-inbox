Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318217AbSIBDsK>; Sun, 1 Sep 2002 23:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318218AbSIBDsK>; Sun, 1 Sep 2002 23:48:10 -0400
Received: from air-2.osdl.org ([65.172.181.6]:35854 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S318217AbSIBDsJ>;
	Sun, 1 Sep 2002 23:48:09 -0400
Date: Sun, 1 Sep 2002 20:51:25 -0700 (PDT)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.32 floppy init and misc fixes
In-Reply-To: <200208311451.QAA00917@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.33L2.0209012048160.22470-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 31 Aug 2002, Mikael Pettersson wrote:

| On Thu, 29 Aug 2002 10:30:14 -0700 (PDT), Randy.Dunlap wrote:
| >On Thu, 29 Aug 2002, Mikael Pettersson wrote:
| >
| >| Floppy has many more problems.
| ...
| >
| >I would add one more: select delay timings are same as in 2.4:
| >#define SEL_DLY (2*HZ/100)
| >but HZ is not the same as in 2.4...
|
| I took a quick glance through floppy.c, and all HZ-dependent
| delays seem to be in jiffies, so I think they are Ok.

I agree except for SEL_DLY as listed above.
It divides by 100 (assuming HZ is 100 I believe).
Same #define in 2.4.current and 2.5.32, so the value
is different in them (with HZ = 1000 in 2.5.32).

-- 
~Randy

