Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265707AbRFXCag>; Sat, 23 Jun 2001 22:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265709AbRFXCaQ>; Sat, 23 Jun 2001 22:30:16 -0400
Received: from lithium.nac.net ([64.21.52.68]:56073 "HELO lithium.nac.net")
	by vger.kernel.org with SMTP id <S265707AbRFXCaL>;
	Sat, 23 Jun 2001 22:30:11 -0400
Date: Sat, 23 Jun 2001 22:29:55 -0400
To: linux-kernel@vger.kernel.org
Subject: Possible freezing bug located after ac13
Message-ID: <20010623222954.A9031@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
From: <tcm@nac.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've recently been going slightly nuts with the fact ac15, 16, and 17
all like deadlocking/slowing to a crawl for seconds/minutes on my K6-III
with 64MB of ram and a swap space of 128MB...

Recently I noticed something VERY odd, I'd been keeping an eye on
gkrellm while I was doing stupid things to produce the problem (a du
as root in X of / generally would always make it pop up) ... And swap
was doing I/O at the time *JUST* before when I'd either deadlock or slow
down to a crawl, and if it recovered, swap would do more I/O...

So. I tried unmounting all swap, and suddenly everything worked fine,
although I couldn't exactly do everythign I wanted of course.

I regression tested this, ac 16,15 and even 14 do this. ac 13 does *not*
- IMHO I think the dead swap patches introduced into 14 may be related
to the problem.

Just my two cents.

Tim
