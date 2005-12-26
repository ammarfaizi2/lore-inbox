Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750790AbVLZV2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750790AbVLZV2I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 16:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbVLZV2I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 16:28:08 -0500
Received: from smtp-out1.blueyonder.co.uk ([195.188.213.4]:5738 "EHLO
	smtp-out1.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S1750790AbVLZV2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 16:28:07 -0500
Message-ID: <43B06063.8030909@blueyonder.co.uk>
Date: Mon, 26 Dec 2005 21:28:03 +0000
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
Organization: blueyonder.co.uk
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: [BUG]: Hard lockups continue with linux-2.6.15-rc1-rc7
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Dec 2005 21:29:01.0671 (UTC) FILETIME=[63A92F70:01C60A63]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tarkan Erimer wrote:
 > Hi all,
 >
 > I'm having hard lockups with all the RCs of linux-2.6.15. I,
 > previously, mentioned this with the subject "[BUG]: Software compiling
 > occasionlly hangs under 2.6.15-rc1/rc2 and 2.6.15-rc1-mm2" in the
 > list. I investigated a bit at found these interesting things.
 >
 > -- Always reproducable. To reproduce:
 > - in console 1, issueing "updatedb"
 > - in console 2, issueing "find / -name "blahblah" -print
 > - in console 3, issueing "emerge -uDp world" (BTW, I'm using Gentoo.)
 > - in console 4, X started.
 > - a few minutes later, system completely freezes. No Alt+SysRq+t
 > works. (Normally, it does)
 >
 > When the system freezes, there is nothing in logs. But hardly, I
 > captured an Alt+SysRq+t. A few seconds (15-20 seconds) before hang. I
 > attached this Alt+SysRq+t and lsmod output. Hope this helps to solve
 > this.
 >
 > PS: These problems never occured in 2.6.14.xx and downwards.
 >
 > Regards.

Don't rule out hardware. This SuSE 10.0 x86 box worked without problems 
on kernels up to 2.6.15-rc6-git2, but I experienced strange apparent 
filesystem corruptions/compile failures running normally and hard 
lockups when running mythtv with 2.6.15-rc6-git6 and 2.6.15-rc7, while 
on the Mandriva 2006 x86 box and the SuSE x86_64 there were no problems. 
Until I found the suspect SDRAM, on some occasions I had to run 
reiserfsck before 2.6.15-rc6-git2 would boot again correctly after 
trying rc6-git6 or -rc7. Finally I got a corruption again with 
2.6.15-rc7, replaced the SDRAM stick with the one taken out previously, 
booted up on 2.6.15-rc7 with no problems. I had run memtest some days 
earlier, but only for a couple of hours. (current uptime 1 day 1.04hrs).
Regards
Sid.
-- 
Sid Boyce ... Hamradio License G3VBV, Licensed Private Pilot
Retired IBM/Amdahl Mainframes and Sun/Fujitsu Servers Tech Support 
Specialist, Cricket Coach
Microsoft Windows Free Zone - Linux used for all Computing Tasks
