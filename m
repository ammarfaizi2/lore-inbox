Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbVJ3Mjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbVJ3Mjy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 07:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbVJ3Mjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 07:39:54 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:16263 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932147AbVJ3Mjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 07:39:53 -0500
Date: Sat, 29 Oct 2005 09:45:13 +0200
From: Pavel Machek <pavel@suse.cz>
To: Pavel Machek <pavel@suse.cz>, Lee Revell <rlrevell@joe-job.com>,
       Hugh Dickins <hugh@veritas.com>, Andi Kleen <ak@suse.de>,
       vojtech@suse.cz, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Disable the most annoying printk in the kernel
Message-ID: <20051029074512.GE1602@openzaurus.ucw.cz>
References: <200510271026.10913.ak@suse.de> <20051028072003.GB1602@openzaurus.ucw.cz> <Pine.LNX.4.61.0510281947040.5112@goblin.wat.veritas.com> <1130532239.4363.125.camel@mindpipe> <20051028205132.GB11397@elf.ucw.cz> <20051028205916.GL4464@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051028205916.GL4464@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Well, keyboard detected and reported an error. Kernel reacted with
> > printk(). You are removing that printk(). I can understand that,
> > printk is really annoying, but I really believe _some_ error handling
> > should be added there if you remove the printk.
> 
> What do you suggest?

Second possibility would be to create "error" event, and send it to userspace.
Userspace would probably ignore it, but that's okay. At least it
has chance to do the right thing.
(AKA dbus event, and nice, friendly "do not panic" message ;-)
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

