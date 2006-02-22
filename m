Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbWBVBKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbWBVBKV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 20:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbWBVBKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 20:10:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:55524 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751224AbWBVBKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 20:10:19 -0500
Date: Tue, 21 Feb 2006 17:06:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Kay Sievers <kay.sievers@suse.de>, penberg@cs.helsinki.fi, gregkh@suse.de,
       bunk@stusta.de, rml@novell.com, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
In-Reply-To: <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0602211700580.30245@g5.osdl.org>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org> <20060217231444.GM4422@stusta.de>
 <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com>
 <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost>
 <20060220010205.GB22738@suse.de> <1140562261.11278.6.camel@localhost>
 <20060221225718.GA12480@vrfy.org> <20060221153305.5d0b123f.akpm@osdl.org>
 <20060222000429.GB12480@vrfy.org> <20060221162104.6b8c35b1.akpm@osdl.org>
 <Pine.LNX.4.64.0602211631310.30245@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 21 Feb 2006, Linus Torvalds wrote:
> 
> The only piece of user-space code we ship with the kernel is the system 
> call trampoline etc that the kernel sets up. THOSE interfaces we can 
> really change, because it changes with the kernel.

Side note: if people want to, we could have other "trampolines" like that, 
so that we could have more user-level code that gets distributed with the 
kernel. It doesn't have to be something that gets mapped into every binary 
either: we could - if we wanted to - have things like shared libraries or 
helper shell scripts or whatever that we expose in /sys/shlib/ that are 
kernel-version dependent.

Then we could perhaps change more things, just because we could change the 
wrappers that actually use them together with the kernel.

To some degree, /initrd was supposed to do things like that, and in 
theory, it still could. However, realistically, 99% of any /initrd is more 
about the distribution than the kernel, so right now we have to count 
/initrd as a distribution thing, not a kernel thing.

		Linus
