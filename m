Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278911AbRKXRyb>; Sat, 24 Nov 2001 12:54:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278940AbRKXRyL>; Sat, 24 Nov 2001 12:54:11 -0500
Received: from news.heim1.tu-clausthal.de ([139.174.234.200]:4666 "EHLO
	neuemuenze.heim1.tu-clausthal.de") by vger.kernel.org with ESMTP
	id <S278911AbRKXRyH>; Sat, 24 Nov 2001 12:54:07 -0500
Date: Sat, 24 Nov 2001 18:54:08 +0100
From: Sven.Riedel@tu-clausthal.de
To: linux-kernel@vger.kernel.org
Cc: nakai@neo.shinko.co.jp
Subject: Re: 2.4.14 Oops during boot (KT133A Problem?)
Message-ID: <20011124185408.A13437@moog.heim1.tu-clausthal.de>
In-Reply-To: <20011115021142.A12923@moog.heim1.tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011115021142.A12923@moog.heim1.tu-clausthal.de>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, the problem got solved (although not in a way I'd consider
satisfactory). After my machine started random segfaulting the day
before yesterday, I memcheck86'ed it again (the last check is a mere two
months ago), and lo - all three RAM chips were broken. Unfortunately, I
discovered this, after this broken RAM caused my /usr partition to go
fubar, resulting in me spending yesterday with a nice little reinstall.
After the reinstall, 2.4.14 booted fine off the harddisk. No more
oopses. 
As to the cause of the problem: I think I can rule out the possibility
of getting a bad kernel compiled due to the bad ram, as I booted once
well below the problem zones with mem=32m and recompiled a kernel with
that and tried to boot - same symptoms. 
Maybe lilo was broken or didn't like the MBR it was written to, or
something along those lines.
Thanks to all who tried to help me!

Regs,
Sven
-- 
Sven Riedel                      sr@gimp.org
Osteroeder Str. 6 / App. 13      sven.riedel@tu-clausthal.de
38678 Clausthal                  "Call me bored, but don't call me boring."
                                 - Larry Wall 
