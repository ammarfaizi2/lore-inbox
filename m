Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267425AbSLEVM1>; Thu, 5 Dec 2002 16:12:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267385AbSLEVEH>; Thu, 5 Dec 2002 16:04:07 -0500
Received: from [195.39.17.254] ([195.39.17.254]:18436 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267425AbSLEU51>;
	Thu, 5 Dec 2002 15:57:27 -0500
Date: Wed, 4 Dec 2002 12:22:36 +0100
From: Pavel Machek <pavel@suse.cz>
To: "David S. Miller" <davem@redhat.com>
Cc: ralf@linux-mips.org, torvalds@transmeta.com, sfr@canb.auug.org.au,
       linux-kernel@vger.kernel.org, anton@samba.org, ak@muc.de,
       davidm@hpl.hp.com, schwidefsky@de.ibm.com, willy@debian.org
Subject: Re: [PATCH] Start of compat32.h (again)
Message-ID: <20021204112236.GC309@elf.ucw.cz>
References: <1038804400.4411.4.camel@rth.ninka.net> <20021201233901.B32203@twiddle.net> <20021202085923.A11711@linux-mips.org> <20021202.000154.38083110.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021202.000154.38083110.davem@redhat.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>    What's the plan to attack 32-bit ioctls?
>   ...
>    but I guess that's going to cause objections?
> 
> Yes, a huge dragon to slay for sure.
> 
> To be honest, I'm happy with what's possible right now.
> SIOCDEVPRIVATE was the biggest problem and that can be
> gradually phased out.
> 
> Let's attack the easy stuff first, then we can retry finding
> a nicer solution to the ioctl bits.
> 
> There are places where real work is needed, for example emulation
> of drivers/usb/core/devio.c is nearly impossible without adding
> some code to devio.c  It keeps around user pointers, and doesn't
> write to the area during that syscall but at some later time
> as the result of another system call.

Right option might be to kill devio.c :-). It has other problems, too,
IIRC.

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
