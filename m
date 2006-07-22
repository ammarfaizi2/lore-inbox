Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWGVPoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWGVPoo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 11:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750784AbWGVPoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 11:44:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35007 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750779AbWGVPoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 11:44:44 -0400
Date: Sat, 22 Jul 2006 08:44:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ian Stirling <tandra@mauve.plus.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: USB snd-usb-audio wedges lsusb when unplugged while playing
 sound.
Message-Id: <20060722084429.6d00217b.akpm@osdl.org>
In-Reply-To: <44C21635.5090808@mauve.plus.com>
References: <44C21635.5090808@mauve.plus.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Jul 2006 13:12:37 +0100
Ian Stirling <tandra@mauve.plus.com> wrote:

> Config/... as my earlier message on USB - though with the bandwidth 
> enforcement
> turned off so it actually plays sound, when plugged into the USB1 port.
> 
> 2.6.17.
> 
> Basically - playing sound with
> mplayer -ao alsa:device=hw=1 or whatever - and then unplugging the
> soundcard completely wedges lsusb/usb configuration, until the mplayer 
> process is killed.
> 
> cat /proc/bus/usb/devices stalls.

Please get the machine into the wedged state, then do

	dmesg -c
	echo t > /proc/sysrq-trigger
	dmesg -s 1000000 > foo

then send foo, thanks.
