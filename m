Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282099AbRLDAML>; Mon, 3 Dec 2001 19:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284722AbRLDAHZ>; Mon, 3 Dec 2001 19:07:25 -0500
Received: from se1.cogenit.fr ([195.68.53.173]:23431 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S284405AbRLCKWX>;
	Mon, 3 Dec 2001 05:22:23 -0500
Date: Tue, 14 Aug 2001 19:38:17 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: PinkFreud <pf-kernel@mirkwood.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Are we going too fast? [upatch]
Message-ID: <20010814193817.A30391@se1.cogenit.fr>
In-Reply-To: <Pine.LNX.4.20.0108141219001.769-100000@eriador.mirkwood.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.20.0108141219001.769-100000@eriador.mirkwood.net>; from pf-kernel@mirkwood.net on Tue, Aug 14, 2001 at 12:25:34PM -0400
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

PinkFreud <pf-kernel@mirkwood.net> :
[...]
> >From Documentation/nmi_watchdog.txt:
> NOTE: currently the NMI-oopser is enabled unconditionally on x86 SMP
> boxes.

My 2.4.8 tree seems to disagree with the doc:
find . -name \*[ch] | xargs fgrep nmi_watchdog | grep =
./arch/i386/kernel/traps.c:int nmi_watchdog = 0;
./arch/i386/kernel/traps.c:__setup("nmi_watchdog=", setup_nmi_watchdog);
./arch/i386/kernel/io_apic.c:           nmi_watchdog = 0;

> I'm not specifically enabling it in LILO, but according to the docs, it's
> enabled already.  Unfortunately, the lockup happens when switching between
> virtual consoles, so even if something WERE printed to the screen, I'm unlikely
> to see it.

Let's hope Mr Murphy took some vacation and please give a try at 
append="nmi_watchdog=1". 

> Side note: The lockup does *NOT* occur on 2.2.19 with SMP.

The console code differs a lot. Trace would help.

-- 
Ueimor
