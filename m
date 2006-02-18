Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932240AbWBRWTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932240AbWBRWTQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 17:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWBRWTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 17:19:16 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:24787 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S932240AbWBRWTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 17:19:15 -0500
To: linuxer@ever.mine.nu
Cc: linux-kernel@vger.kernel.org
Subject: Re: pktcdvd DVD+RW always writes at max drive speed (not media speed)
References: <200602182023.k1IKNNuI012372@rhodes.mine.nu>
From: Peter Osterlund <petero2@telia.com>
Date: 18 Feb 2006 23:19:04 +0100
In-Reply-To: <200602182023.k1IKNNuI012372@rhodes.mine.nu>
Message-ID: <m3r760cntz.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linuxer@ever.mine.nu writes:

> In drivers/block/pktcdvd.c it appears that in the case of DVD
> rewriting, pkt_open_write always sets the write speed to pkt_get_max_speed
> (the maximum writing speed reported by the drive). 
> 
> In my case, I have a new drive capable of 8x re-writing. However, all of
> my existing media is rated for only 4x rewrite speed. 
> 
> When attempting to rw mount these disks, pktcdvd reports:
> 
> Feb 18 00:09:52 ever kernel: pktcdvd: write speed 11080kB/s
> Feb 18 00:09:54 ever kernel: pktcdvd: 54 01 00 00 00 00 00 00 00 00 00 00 -
> sense 00.54.9c (No sense)
> Feb 18 00:09:54 ever kernel: pktcdvd: pktcdvd0 Optimum Power Calibration failed
> 
> And then of course a huge heap of I/O errors on the disk. 

Have you verified that this is caused by the speed setting, ie does it
work correctly if you hack the driver to write at 4x speed?

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
