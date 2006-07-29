Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932643AbWG2H6i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbWG2H6i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 03:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932644AbWG2H6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 03:58:38 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:64194 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S932643AbWG2H6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 03:58:37 -0400
Date: Sat, 29 Jul 2006 09:56:30 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nathan Scott <nathans@sgi.com>
cc: ProfiHost - Stefan Priebe <s.priebe@profihost.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: XFS / Quota Bug in  2.6.17.x and 2.6.18x
In-Reply-To: <20060729075054.B2222647@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.61.0607290953480.20234@yvahk01.tjqt.qr>
References: <44C8A5F1.7060604@profihost.com> <Pine.LNX.4.61.0607281909080.4972@yvahk01.tjqt.qr>
 <20060729075054.B2222647@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > The crash only occurs if you use quota and IDE without barrier support.
>> 
>> I don't quite get this. I do use quota, and have barriers turned 
>> off (either explicitly or because the drive does not support it),
>> but yet no error message like you posted. Do I just have luck?
>
>Heh, no - its more likely you just haven't needed to do a quotacheck
>on a filesystem thats initially mounted readonly (like root often is).

Well I "sometimes" do that, i.e. intentionally turning off quota on the 
running system, to force a recheck on boot. The mount options essentially
are /bin/mount /dev/hda2 / -o ro,usrquota,grpquota and then /bin/mount / -o 
remount,rw
No breakage so far, which is why I wondered. Is it limited to a specific 
kernel version?

>I'm guessing you had quota enabled from earlier barrier-unaware kernels
>and quotacheck only needs to be run during that initial mount.


Jan Engelhardt
-- 
