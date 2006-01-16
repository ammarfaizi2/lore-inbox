Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWAPJsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWAPJsa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 04:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWAPJsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 04:48:30 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:229 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932299AbWAPJs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 04:48:29 -0500
Date: Mon, 16 Jan 2006 10:48:17 +0100
From: Pavel Machek <pavel@suse.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] swsusp: userland interface
Message-ID: <20060116094817.GJ24633@elf.ucw.cz>
References: <200601151831.32021.rjw@sisk.pl> <20060115234300.159688f7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060115234300.159688f7.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The interface documentation is included in the patch.
> > 
> > The patch assumes that the major and minor numbers of the snapshot device
> > will be 10 (ie. misc device) and 231, the registration of which has already been
> > requested.
> 
> Why does it need a statically-allocated major and minor?  misc_register()
> will generate a uevent and the device node should just appear...

Resume part is designed to run from early initrd. I do not think we
should play with udev at thta point. We may not even have writable
filesystem at that point.
								Pavel
-- 
Thanks, Sharp!
