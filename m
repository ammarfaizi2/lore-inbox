Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932658AbWAFHrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658AbWAFHrb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 02:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932660AbWAFHrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 02:47:31 -0500
Received: from xenotime.net ([66.160.160.81]:3300 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932658AbWAFHrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 02:47:31 -0500
Date: Thu, 5 Jan 2006 23:47:18 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: hancockr@shaw.ca, linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
Message-Id: <20060105234718.31111929.rdunlap@xenotime.net>
In-Reply-To: <Pine.LNX.4.61.0601060804100.22809@yvahk01.tjqt.qr>
References: <5rvok-5Sr-1@gated-at.bofh.it>
	<5ryvR-2aN-5@gated-at.bofh.it>
	<5rAHn-5kc-9@gated-at.bofh.it>
	<43BE0592.3040200@shaw.ca>
	<Pine.LNX.4.61.0601060804100.22809@yvahk01.tjqt.qr>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006 08:06:12 +0100 (MET) Jan Engelhardt wrote:

> >> After an oops, we can't really rely on anything. What if the
> >> oops came from the console layer, or a framebuffer driver?
> 
> How about this?:
> 
> Put an "emergency kernel" into a memory location that is being protected in 
> some way (i.e. writing there even from kernel space generates an oops). 
> Upon oops, it gets unlocked and we do some sort of kexec() to it.
> Of course, this probably requires that the unlocking must not be done 
> with help of the standard page mappings.

This is what kexec + kdump is.

---
~Randy
