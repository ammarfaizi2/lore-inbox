Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136704AbREATkt>; Tue, 1 May 2001 15:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136703AbREATkj>; Tue, 1 May 2001 15:40:39 -0400
Received: from femail4.sdc1.sfba.home.com ([24.0.95.84]:38585 "EHLO
	femail4.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S136651AbREATkX>; Tue, 1 May 2001 15:40:23 -0400
Message-ID: <3AEF1122.B543098E@home.com>
Date: Tue, 01 May 2001 12:40:18 -0700
From: Seth Goldberg <bergsoft@home.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lawrence Gold <gold@shell.aros.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: DISCOVERED! Cause of Athlon/VIA KX133 Instability
In-Reply-To: <20010501085939.A40276@shell.aros.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi :)

  And that's exactly what I did :)...  I found that ONLY the combination
of USE_3DNOW and forcing the athlon mmx stuff in (by doing #if 1 in
mmx.c)
results in this wackiness.  I should alos repeat that I *DO* see that
wierdness you described with 3DNOW (in my case, it was that kde locks
up when i try to do something).

 This is damn weird... Who thought channging motherboards would result
in this?

  The other thing i was gunna try is to dump my chipset registers using 
WPCREDIT and WPCRSET and compare them with other people on this list
who have been having the problem.  Maybe our BIOS'es are not
initting/are initting something they should/should not be :).  It this
point, I haven't ruled anything out...

 --Seth


Lawrence Gold wrote:
> 
> Hi, Seth,
> 
> Just wanted to let you know that I got similar results to yours with my
> Epox 8KTA3 motherboard + Thunderbird.  (If you've already seen the thread
> on the kernel mailing list, then please ignore this. ;)
> 
> If I leave the 3DNOW stuff enabled in arch/i386/config.in, but disable the
> K7-specific MMX optimizations, then the system doesn't panic on startup or
> oops continually, but I do get odd behavior, such as awk breaking.
> 
> If I disable just the 3DNOW stuff, then everything works really smoothly.
> I was planning on disabling one-by-one the parts of the code which use
> 3DNOW optimizations to see if there's a particular one that brings about
> instability.
> 
> I'll be sure to cc you on anything I find...
