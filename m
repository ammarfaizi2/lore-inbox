Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272805AbTHEOUN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 10:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272815AbTHEOUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 10:20:13 -0400
Received: from [66.212.224.118] ([66.212.224.118]:30219 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S272805AbTHEOUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 10:20:10 -0400
Date: Tue, 5 Aug 2003 10:08:22 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: FINALLY caught a panic
In-Reply-To: <20030805135046.GO13456@rdlg.net>
Message-ID: <Pine.LNX.4.53.0308051003070.7244@montezuma.mastecende.com>
References: <20030805122354.GL13456@rdlg.net>
 <Pine.LNX.4.53.0308050818130.7244@montezuma.mastecende.com>
 <20030805135046.GO13456@rdlg.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003, Robert L. Harris wrote:

> Code:  Bad EIP value.
> 
> >>EIP; 8011c560 Before first symbol   <=====
> Trace; c011c47d <tasklet_hi_action+5d/90>
> Trace; c011c1ff <do_softirq+6f/d0>
> Trace; c0108bdb <do_IRQ+db/f0>
> Trace; c0105400 <default_idle+0/40>
> Trace; c0105400 <default_idle+0/40>
> Trace; c010ae78 <call_do_IRQ+5/d>
> Trace; c0105400 <default_idle+0/40>
> Trace; c0105400 <default_idle+0/40>
> Trace; c010542c <default_idle+2c/40>
> Trace; c01054a2 <cpu_idle+42/60>
> Trace; c0117e7f <release_console_sem+8f/a0>
> Trace; c0117d8e <printk+11e/140>
> 
>  <0>Kernel panic: Aiee, killing interrupt handler!

It looks like someone freed a tasklet without removing it. But considering 
your kernel cocktail (imported i2c code) it makes it harder for us to 
debug, perhaps if you could try on a newer kernel (i know it'd be hard to 
do if it's production)

-- 
function.linuxpower.ca
