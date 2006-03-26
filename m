Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751429AbWCZUPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbWCZUPt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 15:15:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751511AbWCZUPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 15:15:49 -0500
Received: from smtpout.mac.com ([17.250.248.71]:13783 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751429AbWCZUPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 15:15:48 -0500
In-Reply-To: <Pine.LNX.4.61.0603262042400.28657@yvahk01.tjqt.qr>
References: <5TCqf-E6-49@gated-at.bofh.it> <5TCqf-E6-51@gated-at.bofh.it> <5TCqf-E6-53@gated-at.bofh.it> <5TCqg-E6-55@gated-at.bofh.it> <5TCqf-E6-47@gated-at.bofh.it> <E1FMv1A-0000fN-Lp@be1.lrz> <44266472.5080309@aknet.ru> <Pine.LNX.4.61.0603262042400.28657@yvahk01.tjqt.qr>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <309A3D25-3FF3-421A-AA64-BC35D1230D58@mac.com>
Cc: Stas Sergeev <stsp@aknet.ru>, 7eggert@gmx.de, dtor_core@ameritech.net,
       Linux kernel <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [patch 1/1] pc-speaker: add SND_SILENT
Date: Sun, 26 Mar 2006 15:15:17 -0500
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 26, 2006, at 13:46:24, Jan Engelhardt wrote:
> I like the current approach, that is, load pcspkr to get a beep,  
> load pcspkr+snd-pcsp to get the full blow.
>
> On some servers, I need a mixture of when to allow a beep and when  
> not. In these, I patched the oops and panic functions to make a  
> sound, which implies that pcspkr.ko must be loaded. In turn, I  
> modified vt.c to have the default bell time = 0 to shut /bin/*sh  
> up. Works good.

In a lab I used to run we had a bunch of Linux workstations where  
some users tended to abuse the console beeper.  Our solution was a  
small kernel patch to add a CAP_VT_BEEP which was checked in the  
various console functions before generating a sound or modifying the  
default beep settings.  This allowed our automated hourly chimes to  
run without interference (run from cron as root), while preventing  
users not in the audio group from making sounds (/usr/bin/beep was  
root:audio 04750).

Cheers,
Kyle Moffett

