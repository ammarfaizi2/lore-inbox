Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbVERSvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbVERSvF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 14:51:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbVERSvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 14:51:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27040 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262217AbVERSuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 14:50:51 -0400
Date: Wed, 18 May 2005 20:50:16 +0200
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Lameter <christoph@lameter.com>,
       randy_dunlap <rdunlap@xenotime.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, shai@scalex86.org, ak@suse.de
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt.
Message-ID: <20050518185016.GD1952@elf.ucw.cz>
References: <Pine.LNX.4.62.0505161243580.13692@ScMPusgw> <20050516150907.6fde04d3.akpm@osdl.org> <Pine.LNX.4.62.0505161934220.25315@graphe.net> <20050516194651.1debabfd.rdunlap@xenotime.net> <Pine.LNX.4.62.0505161954470.25647@graphe.net> <Pine.LNX.4.58.0505162029240.18337@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505162029240.18337@ppc970.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 	config HZ
> 		int
> 		default 100 if HZ_100
> 		default 250 if HZ_250
> 		default 1000 if HZ_1000
> 
> and now you can just do
> 
> 	#define HZ CONFIG_HZ
> 
> or something. You can even maje the Kconfig parts be a separate Kconfig.HZ
> file, and have both the x86 and x86-64 Kconfig files just include the
> common part (since it's a generic issue, not even PC-related: we might
> want to allow things like 60Hz frequencies for CONFIG_EMBEDDED etc, and
> these choices are really valid on any system that allows for the timer to
> be reprogrammed)
> 
> The above is obviously totally untested, but it doesn't look any more
> complex than having a fairly ugly (and much less user-friendly) check at
> compile-time.

Please don't do this, CONFIG_NO_IDLE_HZ patches are better solution,
and they worked okay last time I tried them.
								Pavel
