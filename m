Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVABTiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVABTiA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 14:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVABTiA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 14:38:00 -0500
Received: from gprs215-225.eurotel.cz ([160.218.215.225]:56707 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261249AbVABThn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 14:37:43 -0500
Date: Sun, 2 Jan 2005 20:37:24 +0100
From: Pavel Machek <pavel@ucw.cz>
To: luto@myrealbox.com, aebr@win.tue.nl, linux-kernel@vger.kernel.org
Subject: Re: the umount() saga for regular linux desktop users
Message-ID: <20050102193724.GA18136@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
>X-Original-To: pavel@atrey.karlin.mff.cuni.cz
>From: Andy Lutomirski <luto@myrealbox.com>
>To: Andries Brouwer <aebr@win.tue.nl>
>Cc: linux-kernel@vger.kernel.org
>Subject: Re: the umount() saga for regular linux desktop users
>
>Andries Brouwer wrote:
>>On Fri, Dec 31, 2004 at 05:41:02PM +0000, William wrote:
>>
>>
>>>Regularly, when attempting to umount() a filesystem I receive 
>>>'device is busy' errors. The only way (that I have found) to solve 
>>>these problems is to go on a journey into processland and kill all 
>>>the guilty ones that have tied themselves to the filesystem 
>>>concerned.
>>
>>
>>Do you know about the existence of the MNT_DETACH flag of umount(2),
>>or the -l option of umount(8)?
>>
>>It seems that does at least some of the things you are asking for.

Well, umount -l can be handy, but it does not allow you to get your CD
back from the drive.

umount --kill that kills whoever is responsible for filesystem being
busy would solve part of the problem (that can be done in userspace,
today).

Of course, even nicer would be "filesystem goes away now, all
operations fail", but that needs kernel support.

>Sometimes I want to "unmount cleanly, damnit, and I don't care if 
>applications that are currently accessing it lose data."  Windows can 
>do this, and it's _useful_.

Agreed. When some machine refuses to eject cd because it is
busy... That's bad. I have strong temptation to just remove AC power,
plug it back and then claim my CD...

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
