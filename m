Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263034AbUCSRQV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 12:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263064AbUCSRQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 12:16:21 -0500
Received: from waste.org ([209.173.204.2]:645 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263034AbUCSRQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 12:16:19 -0500
Date: Fri, 19 Mar 2004 11:16:15 -0600
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] inflate.c rework arch testing needed
Message-ID: <20040319171615.GN11010@waste.org>
References: <20040318231006.GK11010@waste.org> <20040319103126.A12519@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040319103126.A12519@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 19, 2004 at 10:31:26AM +0000, Russell King wrote:
> On Thu, Mar 18, 2004 at 05:10:06PM -0600, Matt Mackall wrote:
> > I've reworked the mess that is lib/inflate.c, including:
> 
> Please don't - this will probably break the PIC decompressor on ARM.

If it works now, I don't see why it should. My last version of this
was test-booted on ARM. The only thing here that could conceivably
break PIC is the change to linking but the old include hack will
continue to work. At any rate my other cleanups should be orthogonal
to all that.
 
> There are un-merged patches in the pipeline which make this all work
> correctly with todays toolchains - which mostly means getting rid of
> all static data to make the compiler produce the right relocations.

Well perhaps you could send them to me.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
