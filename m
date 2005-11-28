Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbVK2OpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbVK2OpY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 09:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbVK2OpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 09:45:24 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:53371 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1751360AbVK2OpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 09:45:24 -0500
Message-ID: <438B70AA.7090805@tmr.com>
Date: Mon, 28 Nov 2005 16:03:38 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luke-Jr <luke-jr@utopios.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd doesn't replace ide-scsi?
References: <200511281218.17141.luke-jr@utopios.org>
In-Reply-To: <200511281218.17141.luke-jr@utopios.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke-Jr wrote:
> Note: results are with 2.6.13 (-gentoo-r4 + supermount) and 2.6.14 (-gentoo)
> I've been struggling with burning DVD+R DL discs and upgrading the firmware on 
> my DVD burner, and just today decided to rmmod ide-cd and try using ide-scsi. 
> Turns out it works... so is ide-cd *supposed* to handle cases other than 
> simple reading and burning or is this a bug? If not a bug, should ide-scsi 
> really be marked as deprecated?
> Also, two bugs with ide-scsi:
> 1. On loading the module, it detects and allocates 6 SCSI devices for a single 
> DVD burner (Toshiba ODD-DVD SD-R5272); kernel log for this event attached
> 2. On attempted unloading of the module, rmmod says 'Killed' and the module 
> stays put, corrupt. There was some kind of error in dmesg, but it appears to 
> have avoided syslog-- If I see it again, I'll save it.

I think you may have the probe-all-LUNs set, and a CD burner which 
responds to more than one. That's one possible cause for this.

Unfortunately using ide-cd still doesn't have the code set to allow all 
burning features to work if you are not root. Even if you have 
read+write there's one command you need to do multi-session which is 
only allowed to root. Works fine for single sessions, I guess that's all 
someone uses.

Haven't tried unloading the module, so I have no advice on that other 
than "don't do that."
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

