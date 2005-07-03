Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVGCJJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVGCJJa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 05:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261236AbVGCJJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 05:09:30 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:55540 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S261242AbVGCJIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 05:08:14 -0400
To: Miles Lane <miles.lane@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-rc1-mm1 -- Synaptics touchpad not detected correctly
References: <a44ae5cd05070300097a18790a@mail.gmail.com>
From: Peter Osterlund <petero2@telia.com>
Date: 03 Jul 2005 11:08:09 +0200
In-Reply-To: <a44ae5cd05070300097a18790a@mail.gmail.com>
Message-ID: <m3acl4p892.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane <miles.lane@gmail.com> writes:

> Hello,
> 
> Any ideas why my Synaptics touchpad isn't getting recognized
> as supporting multi-finger tap detection?  I haven't seen detection
> work with earlier kernels, either.  However, multifinger taps work
> under WinXP.
> 
> dmesg is reporting:
> 
>            Synaptics Touchpad, model: 1, fw: 5.10, id: 0x258eb1, caps:
> 0xa04713/0x0
>            input: SynPS/2 Synaptics TouchPad on isa0060/serio1

It looks like it is recognized. Bit 1 in the caps word tells if the
touchpad supports multi-finger detection. Earlier kernels used to
report this in plain text form, but it was considered bloating dmesg
unnecessarily, so now you only get the raw capability bits reported.

Anyway, you also need to use the X driver from

        http://web.telia.com/~u89404340/touchpad/index.html

to take advantage of multi-finger taps. The kernel itself doesn't bind
any special actions to them.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
