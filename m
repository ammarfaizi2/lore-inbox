Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933778AbWKWP1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933778AbWKWP1j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 10:27:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933786AbWKWP1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 10:27:38 -0500
Received: from mx1.suse.de ([195.135.220.2]:41696 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S933778AbWKWP1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 10:27:38 -0500
Date: Thu, 23 Nov 2006 16:27:34 +0100
From: Andi Kleen <ak@suse.de>
To: Jiri Kosina <jkosina@suse.cz>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Reuben Farrelly <reuben-linuxkernel@reub.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] x86_64: fix build without HOTPLUG_CPU (was Re: 2.6.19-rc6-mm1)
Message-ID: <20061123152734.GG29738@bingen.suse.de>
References: <20061123021703.8550e37e.akpm@osdl.org> <45657A41.2040400@reub.net> <Pine.LNX.4.64.0611231503520.8069@twin.jikos.cz> <p731wnu42vt.fsf@bingen.suse.de> <Pine.LNX.4.64.0611231611510.8069@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611231611510.8069@twin.jikos.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 04:17:00PM +0100, Jiri Kosina wrote:
> On Thu, 23 Nov 2006, Andi Kleen wrote:
> 
> > > cpu_vsyscall_notifier() is defined only when CONFIG_HOTPLUG_CPU is 
> > > defined.
> > It's already long fixed in Linus' tree (in 
> > 6b3d1a95ba714bfb1cc81362f7f3e01b7654b4f3) I wonder why that didn't 
> > makeit into Andrew's. Andrew, time to update your linus-patch?
> 
> Well, is it really? 6b3d1a95ba714bfb1cc81362f7f3e01b7654b4f3 adds the 
> ifdef around the cpu_vsyscall_notifier() declaration, but later it's 
> passed as parameter to hotcpu_notifier() unconditionally. This is fixed by 
> the patch I sent.

hotcpu_notifier is a macro that expands to nothing for !CONFIG_HOTPLUG_CPU

-Andi
