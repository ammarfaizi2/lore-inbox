Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750933AbWBLTzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbWBLTzX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 14:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWBLTzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 14:55:23 -0500
Received: from cantor2.suse.de ([195.135.220.15]:12990 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750765AbWBLTzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 14:55:22 -0500
Date: Sun, 12 Feb 2006 20:55:15 +0100
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Roger Leigh <rleigh@whinlatter.ukfsn.org>,
       debian-powerpc@lists.debian.org
Subject: Re: 2.6.16-rc2 powerpc timestamp skew
Message-ID: <20060212195514.GA18521@suse.de>
References: <87pslspkj5.fsf@hardknott.home.whinlatter.ukfsn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87pslspkj5.fsf@hardknott.home.whinlatter.ukfsn.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sun, Feb 12, Roger Leigh wrote:

> In both these cases, the chrony NTP daemon is running, if that might
> be a problem.

I dont run Debian, but:

My G4/466 has the hwclock at 1970 for some reason. The early bootscripts
call klogd, which calls nanosleep. This syscall takes 3 hours to complete.

A bit userland debugging shows that hwclock is 1970, system time is also
1970 when nanosleep starts. But when it returns, the time is correct.
Its already at the end of the /etc/init.d/boot.d/S* scripts, nothing
else runs there. Bug exists since at least 2.6.15-git12, 2.6.15 was ok.
Fatfingerd kernel debug patch and lost remote access...
