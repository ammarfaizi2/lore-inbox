Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264506AbRFXUmM>; Sun, 24 Jun 2001 16:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264496AbRFXUmC>; Sun, 24 Jun 2001 16:42:02 -0400
Received: from ohiper1-198.apex.net ([209.250.47.213]:34823 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S264490AbRFXUlo>; Sun, 24 Jun 2001 16:41:44 -0400
Date: Sun, 24 Jun 2001 15:41:34 -0500
From: Steven Walter <srwalter@yahoo.com>
To: andyw@edafio.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Crash on boot (2.4.5)
Message-ID: <20010624154134.A9203@hapablap.dyn.dhs.org>
In-Reply-To: <001001c0fcde$a9422ec0$ecbd3fd8@wamprat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <001001c0fcde$a9422ec0$ecbd3fd8@wamprat>; from the_toastman@aristotle.net on Sun, Jun 24, 2001 at 01:51:09PM -0500
X-Uptime: 3:28pm  up 1 day, 14:11,  1 user,  load average: 1.14, 1.34, 1.27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2001 at 01:51:09PM -0500, Daniel Fraley wrote:
> Hi, everyone..  I'm borrowing my roommate's email, so please send replies to
> andyw@edafio.com.  Thanks!
> 
> Here's my problem...  when I boot anything 2.4, I get several oopsen in a
> row, all of which are either (most commonly) kernel paging request could not
> be handled, or (much less common) unable to handle kernel Null pointer
> dereference.  I will send any info on request, but here's my hardware and
> kernel config:
> 
> iWill KKR-266R (Via 8363 Northbridge, 686B south)
> AMD tbird 1GHz
> 256MB cas2 pc133 sdram
> ATI Radeon DDR 64MB VIVO
> Kingston KNE120TX (Realtek 8139 chip)
> SBLive! 5.1
> IBM GXP75 30GB (on the via ide controller)
> Pioneer 16x dvd
> ls120
> 
> This happens regardless if I turn on swap or not.  When swap is on, it is a
> 128MB partition (and yes, I'm aware of the recommendation of 2x RAM, but I
> believe I read somewhere that someone was working on that, and I didn't want
> to waste the extra 384MB on swap).
> 
> Is there anything I can do to fix this?
> 
> -- andyw
> 
> p.s., booting with devfs=nomount is better, but still causes oopsen (I get
> to a login prompt, but if I do much more than mount a disk a copy to it, the
> system freaks)

>From the look of things, you're being bitten by the VIA southbridge
problem.  As I've gathered, its some sort of interaction with that chip
and the 3DNow! fast copy routines the kernel uses.

If you compile the kernel for a 686, does the problem go away?  What
about 586 or lower?  If so, I believe there are some people working on
finding common aspects of the hardware that experience this problem,
though I don't remember who.  You should get in contact with them, or
they might get into contact with you.

Good luck on working this out.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
