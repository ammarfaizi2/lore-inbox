Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310924AbSCTAG0>; Tue, 19 Mar 2002 19:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310953AbSCTAGR>; Tue, 19 Mar 2002 19:06:17 -0500
Received: from ohiper1-213.apex.net ([209.250.47.228]:38929 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S310924AbSCTAGD>; Tue, 19 Mar 2002 19:06:03 -0500
Date: Tue, 19 Mar 2002 18:03:30 -0600
From: Steven Walter <srwalter@yahoo.com>
To: Danijel Schiavuzzi <dschiavu@public.srce.hr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Screen corruption in 2.4.18
Message-ID: <20020320000330.GA15278@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	Danijel Schiavuzzi <dschiavu@public.srce.hr>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200203192112.WAA09721@jagor.srce.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uptime: 17:57:24 up 6 days,  6:02,  1 user,  load average: 1.11, 1.12, 1.09
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 10:12:18PM +0100, Danijel Schiavuzzi wrote:
> Hi.
> 
> Some two weeks ago I posted here a kernel bug report regarding
> a screen corruption issue. You can find it here:
> http://www.uwsg.indiana.edu/hypermail/linux/kernel/0203.0/1577.html
> 
> As I didn't know if it's my hardware that is the cause of corruption,
> searched over the Internet and found that Thomas Brehm is also
> having the same problem, and he has the same motherboard as me
> (MSI MS-6340M, VIA KM133 chipset - VT8365 north + VIA686B south bridge).
> 
> Short problem description: 2.4.17 kernel works fine, but any kernel
> higher than this makes the screen corrupted in any text or VESA fb
> mode. In standard text mode, the screen gets filled with vertical
> lines. In vesafb mode, random horizontal lines appear on the screen.
> 
> However, I made up the 2.4.18 kernel to boot up properly by 
> replacing the file
> 
> 	./linux/arch/i386/pci-pc.c
> 
> with that from the 2.4.17 kernel. The kernel runs fine now.
> 
> So, what seems to make the screen corruption?

I also experienced this problem on a VIA board.  I tried removing my
chipset from the list of those which need the fix-up from pci-pc.c, and
this elimiated all the corruption.  It would seem that this chip, at
least on our specific boards, does not need the fix-up, and in fact it
is detrimental.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
Well, who's mad now?
			-- Montgomery C. Burns
