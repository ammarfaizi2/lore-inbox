Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbTJWVmO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 17:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261823AbTJWVmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 17:42:14 -0400
Received: from [63.194.133.30] ([63.194.133.30]:33928 "EHLO penngrove.fdns.net")
	by vger.kernel.org with ESMTP id S261821AbTJWVmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 17:42:13 -0400
From: John Mock <kd6pag@qsl.net>
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kill unneccessary debug printk
Message-Id: <E1ACnDZ-0005GV-00@penngrove.fdns.net>
Date: Thu, 23 Oct 2003 14:42:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   > Actually, that 'printk' is useful.  As i understand it, the only way software
   > suspend is going to work is that if the same video mode is used on resume as
   > on booting.  If one uses "vga=ask", then one can 'dmesg | grep' to generate
   > a proper string for 'lilo -R' (which i already do to make sure the correct
   > kernel gets resumed during testing).  If i'm mistaken about needing to set
   > VGA mode identically on resume, then i have no objection to removing the
   > printk.

   Oops, someone is using my debug printk :-(. I'll at least try
   to merge it with some other msg, so it does not waste full
   line.

Better yet, let's take this opportunity to do this more cleanly.  How 
about having something like /sys/power/vmode (or /proc/...) contain that 
inforemation instead?  With luck, it might even be few kernel bytes than
the original printk (or at least not much more).  (I know nothing about
either /proc or /sys, so it would take me awhile to suggest a patch).

Thanks for the kind response.
				    -- JM
