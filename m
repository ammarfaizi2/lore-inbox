Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317202AbSEXRd4>; Fri, 24 May 2002 13:33:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317209AbSEXRdz>; Fri, 24 May 2002 13:33:55 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:51893 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317202AbSEXRdr>;
	Fri, 24 May 2002 13:33:47 -0400
Date: Fri, 24 May 2002 19:33:45 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: linux-kernel@vger.kernel.org
Subject: asm/timex.h
Message-ID: <20020524193345.A21559@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have several questions about asm/timex.h

1) Who uses it? The kernel certainly doesn't. Perhaps NTP?

2) CLOCK_TICK_RATE is defined on i386 and similar archs
   to be 1193180. This is wrong, because the real frequency
   of the i8253 PIT timer is 14.31818 MHz / 12 = 1.11931816 MHz,
   so CLOCK_TICK_RATE should be 1193182. Should it be fixed?

3) What if an architecture doesn't have a compile-time known
   CLOCK_TICK_RATE? I suppose I cannot just #define it to a variable,
   because the kernel doesn't use it, and that probably means userland
   does ...

Anyone knows the answers?

-- 
Vojtech Pavlik
SuSE Labs
