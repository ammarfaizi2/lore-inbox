Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751410AbWBKLaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbWBKLaR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 06:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751412AbWBKLaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 06:30:17 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:18936 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1751410AbWBKLaQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 06:30:16 -0500
To: iSteve <isteve@rulez.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Packet writing issue on 2.6.15.1
References: <20060211103520.455746f6@silver>
From: Peter Osterlund <petero2@telia.com>
Date: 11 Feb 2006 12:30:03 +0100
In-Reply-To: <20060211103520.455746f6@silver>
Message-ID: <m3r76a875w.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

iSteve <isteve@rulez.cz> writes:

> Greetings,
> I've wanted to try out packet writing on my Plextor CD-RW (PLEXTOR CD-R
> PREMIUM, ATAPI CD/DVD-ROM drive). Setting up device via "pktcdvd 0 /dev/hdc"
> went without any problem and I had the device created. 
> 
> I then mounted UDF on the device, /proc/mounts reported it as rw. However, when
> attempting to write and then sync, the sync fails and I get sinister output in
> dmesg (below). I wonder what causes this issue and if I may resolve it somehow.

> Kernel: 2.6.15.1 + swsup2, vesafb-tng (as module, not loaded), squashfs.

> Dmesg output since the first moment pktcdvd is involved:
> 
> pktcdvd: inserted media is CD-RW
> pktcdvd: detected zero packet size!
> pktcdvd: Variable packets, 32 blocks, Mode-1 disc

Unfortunately the driver doesn't support variable packet sizes. You
have to format the disc with a fixed packet size.

Incidentally, the latest git tree (2.6.16-rc2-git10) already contains
a change which would have made the mount command fail in this case.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
