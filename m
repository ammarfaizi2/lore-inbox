Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757393AbWKWPRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757393AbWKWPRb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 10:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757394AbWKWPRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 10:17:31 -0500
Received: from twin.jikos.cz ([213.151.79.26]:25741 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S1757393AbWKWPRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 10:17:30 -0500
Date: Thu, 23 Nov 2006 16:17:00 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
X-X-Sender: jikos@twin.jikos.cz
To: Andi Kleen <ak@suse.de>
cc: linux-kernel@vger.kernel.org,
       Reuben Farrelly <reuben-linuxkernel@reub.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86_64: fix build without HOTPLUG_CPU (was Re:
 2.6.19-rc6-mm1)
In-Reply-To: <p731wnu42vt.fsf@bingen.suse.de>
Message-ID: <Pine.LNX.4.64.0611231611510.8069@twin.jikos.cz>
References: <20061123021703.8550e37e.akpm@osdl.org> <45657A41.2040400@reub.net>
 <Pine.LNX.4.64.0611231503520.8069@twin.jikos.cz> <p731wnu42vt.fsf@bingen.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2006, Andi Kleen wrote:

> > cpu_vsyscall_notifier() is defined only when CONFIG_HOTPLUG_CPU is 
> > defined.
> It's already long fixed in Linus' tree (in 
> 6b3d1a95ba714bfb1cc81362f7f3e01b7654b4f3) I wonder why that didn't 
> makeit into Andrew's. Andrew, time to update your linus-patch?

Well, is it really? 6b3d1a95ba714bfb1cc81362f7f3e01b7654b4f3 adds the 
ifdef around the cpu_vsyscall_notifier() declaration, but later it's 
passed as parameter to hotcpu_notifier() unconditionally. This is fixed by 
the patch I sent.

-- 
Jiri Kosina
SUSE Labs

