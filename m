Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262229AbVDXCLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbVDXCLR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 22:11:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbVDXCLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 22:11:17 -0400
Received: from gate.crashing.org ([63.228.1.57]:60336 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262229AbVDXCLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 22:11:15 -0400
Subject: Re: 2.6.12-rc2-mm3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Juergen Kreileder <jk@blackdown.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Oleg Nesterov <oleg@tv-sign.ru>
In-Reply-To: <87fyxhj5p1.fsf@blackdown.de>
References: <20050411012532.58593bc1.akpm@osdl.org>
	 <87wtr8rdvu.fsf@blackdown.de> <87u0m7aogx.fsf@blackdown.de>
	 <1113607416.5462.212.camel@gaston> <877jj1aj99.fsf@blackdown.de>
	 <20050423170152.6b308c74.akpm@osdl.org>  <87fyxhj5p1.fsf@blackdown.de>
Content-Type: text/plain
Date: Sun, 24 Apr 2005 12:15:28 +1000
Message-Id: <1114308928.5443.13.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-04-24 at 03:59 +0200, Juergen Kreileder wrote:

> I'm might be the only one using evdev on ppc64.
> 
> And I don't know how popular LVM2 is on disks with Macintosh labels.
> I had to set it up manually when I installed the machine, Debian's
> installer couldn't handle it at that time.
> 
> Workload is normal, the lockups happen with just X and Azaereus.
> (The machine also runs mysqld, apache, and a few other daemons.  But I
> don't have to put load on these to make the machine lock up.)

If you make sure you have CONFIG_XMON enabled and CONFIG_BOOTX_TEXT, and
make sure X has "UseFBDev" option, do you drop into xmon before the
lockup ?

Also, do you have another machine at hand ? if yes, then we can try to
revive my old firewire based debug tools we used to track things down in
linus tree.

I'll have a look at the timer patch next week, they might have some
subtle race caused by a lack of memory barrier. I've had to debug some
of those in early timer code, and those are really nasty, they usually
only trigger under some subtle conditions, like ... heavy networking.

Ben.


