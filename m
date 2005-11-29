Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbVK2TMQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbVK2TMQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 14:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751035AbVK2TMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 14:12:16 -0500
Received: from CPE-24-31-244-49.kc.res.rr.com ([24.31.244.49]:36808 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S1750949AbVK2TMP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 14:12:15 -0500
From: Luke-Jr <luke-jr@utopios.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ide-cd doesn't replace ide-scsi?
Date: Tue, 29 Nov 2005 19:12:20 +0000
User-Agent: KMail/1.9
References: <200511281218.17141.luke-jr@utopios.org> <438B70AA.7090805@tmr.com>
In-Reply-To: <438B70AA.7090805@tmr.com>
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke-jr@jabber.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511291912.21255.luke-jr@utopios.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 November 2005 21:03, you wrote:
> Luke-Jr wrote:
> > Note: results are with 2.6.13 (-gentoo-r4 + supermount) and 2.6.14
> > (-gentoo) I've been struggling with burning DVD+R DL discs and upgrading
> > the firmware on my DVD burner, and just today decided to rmmod ide-cd and
> > try using ide-scsi. Turns out it works... so is ide-cd *supposed* to
> > handle cases other than simple reading and burning or is this a bug? If
> > not a bug, should ide-scsi really be marked as deprecated?
> > Also, two bugs with ide-scsi:
> > 1. On loading the module, it detects and allocates 6 SCSI devices for a
> > single DVD burner (Toshiba ODD-DVD SD-R5272); kernel log for this event
> > attached 2. On attempted unloading of the module, rmmod says 'Killed' and
> > the module stays put, corrupt. There was some kind of error in dmesg, but
> > it appears to have avoided syslog-- If I see it again, I'll save it.
>
> I think you may have the probe-all-LUNs set, and a CD burner which
> responds to more than one. That's one possible cause for this.

Yep, it was set. I'll try turning it off.

> Unfortunately using ide-cd still doesn't have the code set to allow all
> burning features to work if you are not root. Even if you have read+write
> there's one command you need to do multi-session which is only allowed to
> root. Works fine for single sessions, I guess that's all someone uses.

I'm pretty sure I tried doing everything as root days before I even considered 
ide-scsi... In regards to firmware upgrades, I wouldn't expect non-root to be 
allowed to, even with rw access.

> Haven't tried unloading the module, so I have no advice on that other than
> "don't do that." 

Well, I had reasons... =p
The first time, I was going to switch back to ide-cd (for DMA), and the second 
time was because the drive was stuck on Busy and I'm not sure of any (other?) 
way to reset it without hotplugging the IDE power cable (which I'm sure isn't 
a good idea and I don't want to risk).
-- 
Luke-Jr
Developer, Utopios
http://utopios.org/
