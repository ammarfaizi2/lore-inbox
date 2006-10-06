Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422717AbWJFWpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422717AbWJFWpU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 18:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932660AbWJFWpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 18:45:19 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:38549 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1161069AbWJFWpS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 18:45:18 -0400
Date: Sat, 7 Oct 2006 00:44:36 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net,
       ismail@pardus.org.tr
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Message-ID: <20061006224436.GD29690@elf.ucw.cz>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <20061001171912.b7aac1d8.akpm@osdl.org> <20061002003908.GA18707@lists.us.dell.com> <20061005103657.GA4474@ucw.cz> <20061006211751.GA31887@lists.us.dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061006211751.GA31887@lists.us.dell.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Please move it into the kernel where it belongs, and use lcd
> > brightness subsystem like everyone else.
> 
> We've been through this before.
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114067198323596&w=2
> 
> In addition, the SMI call used to change the backlight level *may*
> require (if configured by the sysadmin in BIOS), a password be
> entered.

This is crazy, password-protected backlight level?

Can you make sure this crazyness does not infect newer models?

> This begs for a common userspace app that can grok libsmbios and
> kernel interfaces both, and use the appropriate method on each, rather
> than just putting it all in the kernel.

Kernel is expected to provide hardware abstraction. libsmbios will
mean person able to change backlight will be able to do lots of
strange stuff...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
