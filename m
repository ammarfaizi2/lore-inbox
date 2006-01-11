Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932755AbWAKBZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932755AbWAKBZi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 20:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932759AbWAKBZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 20:25:38 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:37347 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932755AbWAKBZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 20:25:37 -0500
Subject: Re: soundblaster pnp ide won't pnp
From: Lee Revell <rlrevell@joe-job.com>
To: Fredrick O Jackson <fred@electronsrus.com>
Cc: linux-kernel@vger.kernel.org,
       ALSA user list <alsa-user@lists.sourceforge.net>
In-Reply-To: <200601101916.28019@bits.electronsrus.com>
References: <200601101916.28019@bits.electronsrus.com>
Content-Type: text/plain
Date: Tue, 10 Jan 2006 20:25:34 -0500
Message-Id: <1136942735.2007.120.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 19:16 -0600, Fredrick O Jackson wrote:
> ok, so far Ive tried with and without isapnp support in the kernel, I've 
> toggled the PNP OS, and ACPI switches in the bios, I've tried compiling the 
> drivers into the kernel (hd, ide, ide-disk, isapnp, ide-pnp, and others) on 
> 2.6.14, 2.6.15 and 2.4.27. I've used kernel command lines. I usually get 
> messages similar to that below (at the bottom). I also cannot find the 
> modules ide, ide-probe, or ide-detect which are documented in the 
> Documentation directory.
> 
> what method is recommended and what kernel would you suggest?
> 

> Jan 10 12:42:41 pthree kernel: ide: failed opcode was: unknown
> Jan 10 12:42:41 pthree kernel: ide2: reset: success
> Jan 10 12:43:11 pthree kernel: hde: irq timeout: status=0x50 { DriveReady 
> SeekComplete }
> 

You don't say whether you are trying to use the ALSA or OSS driver.  And
your dmesg has no mention at all of a sound card, it just shows that hde
is failing.

First, if you were trying to load the OSS driver, try the ALSA driver,
and post the output of dmesg when loading snd-sb16 and the output of
"cat /proc/asound/cards".

Lee

