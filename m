Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262651AbUKELgv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbUKELgv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 06:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbUKELgv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 06:36:51 -0500
Received: from cantor.suse.de ([195.135.220.2]:54153 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262651AbUKELgu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 06:36:50 -0500
Date: Fri, 5 Nov 2004 12:30:17 +0100
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>, Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>
Subject: Re: 2.6.10-rc1-mm3
Message-ID: <20041105113017.GD8349@wotan.suse.de>
References: <20041105001328.3ba97e08.akpm@osdl.org> <200411051041.17940.l_allegrucci@yahoo.it> <20041105102204.GA4730@elte.hu> <20041105110951.GA29702@elte.hu> <20041105112052.C16270@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041105112052.C16270@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "first" needs to be able to handle being set to virtual address 0x8000
> since, for some CPUs, it is absolutely vital that we keep the first
> _page_ of memory mapped, but user executables are loaded at 0x8000.
> 
> Note that the PGD increment is 2MB on ARM.

I think I handled the ARM hac^wcase correctly, but I wasn't able to test it
(hint hint). Even with Ingo's changes it would still work because
of the guarding ifs. 

-Andi

