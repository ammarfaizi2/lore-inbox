Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261397AbUKSMWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261397AbUKSMWY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 07:22:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbUKSMWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 07:22:15 -0500
Received: from cantor.suse.de ([195.135.220.2]:62186 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261384AbUKSMVp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 07:21:45 -0500
Date: Fri, 19 Nov 2004 13:19:10 +0100
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andi Kleen <ak@suse.de>, David Woodhouse <dwmw2@infradead.org>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: RFC: let x86_64 no longer define X86
Message-ID: <20041119121909.GF21483@wotan.suse.de>
References: <20041119005117.GM4943@stusta.de> <20041119085132.GB26231@wotan.suse.de> <419DC922.1020809@pobox.com> <20041119103418.GB30441@wotan.suse.de> <1100863700.21273.374.camel@baythorne.infradead.org> <20041119115539.GC21483@wotan.suse.de> <1100865050.21273.376.camel@baythorne.infradead.org> <20041119120549.GD21483@wotan.suse.de> <419DE33E.2000208@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419DE33E.2000208@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 19, 2004 at 07:12:46AM -0500, Jeff Garzik wrote:
> Andi Kleen wrote:
> >I don't know details about the driver, but it's not enabled on x86-64 
> >because x86-64 doesn't have ISA set.
> 
> 
> which I disagree with.  CONFIG_ISA should include southbridge devices 
> behind a PCI<->ISA bridge.  There is zero value to a more stricter 
> "there is a physical ISA bus in this machine" definition.

There is. It gets rid of many tens of drivers that are not and will never
be 64bit clean and have a snowball in hell chances to work on x86-64.

In theory you could invent a new ISA_SLOT or ISA_BROKEN config for them,
but since ISA does the job quite well for near everybody except
for one or two corner cases I don't see any sense in changing it.

-Andi
