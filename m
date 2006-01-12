Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbWALI6r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbWALI6r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 03:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbWALI6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 03:58:47 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:16326 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030333AbWALI6r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 03:58:47 -0500
Date: Thu, 12 Jan 2006 09:58:37 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, patrizio.bassi@gmail.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [BUG 2.6.15-git5] new alsa power management completly broken
Message-ID: <20060112085837.GD1670@elf.ucw.cz>
References: <20060111234810.3ffe241c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111234810.3ffe241c.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 11-01-06 23:48:10, Andrew Morton wrote:
> 
> swsusp problems...

Where? :-)

> sorry for delay, however i tested it and works perfectly.
> 
> just 2 things to notice:
> 1) [unrelated to this bug] swsusp ram pages write and read is really
> slower than 2.6.14 one. i didn't follow changes, so don't know what
> happened

That's a feature. echo 0 > /sys/power/image_size should make it behave
like 2.6.14.

> 2) when i suspend i continue to see errors 0x660 in my tty. The strange
> thing is that after resume they are no more in dmesg!
> strange. however, as i wrote before, it works.

That's not so strange. Messages that happen after memory snapshot are
lost (of course).
								Pavel
-- 
Thanks, Sharp!
