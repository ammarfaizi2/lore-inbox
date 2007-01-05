Return-Path: <linux-kernel-owner+w=401wt.eu-S1750778AbXAEVPr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbXAEVPr (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 16:15:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbXAEVPr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 16:15:47 -0500
Received: from smtp.osdl.org ([65.172.181.24]:32937 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750780AbXAEVPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 16:15:46 -0500
Date: Fri, 5 Jan 2007 13:15:16 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Mariusz Kozlowski <m.kozlowski@tuxland.pl>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: 2.6.20-rc3-mm1
Message-Id: <20070105131516.bd9d8f45.akpm@osdl.org>
In-Reply-To: <1168030536.22458.28.camel@localhost.localdomain>
References: <20070104220200.ae4e9a46.akpm@osdl.org>
	<200701051723.08112.m.kozlowski@tuxland.pl>
	<1168030536.22458.28.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Jan 2007 07:55:36 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2007-01-05 at 17:23 +0100, Mariusz Kozlowski wrote:
> > Hello, 
> > 
> > 	Doesn't build on my iMac G3 based garage jukebox ;-)
> > 
> > arch/powerpc/kernel/of_platform.c:479: error: unknown field 'multithread_probe' specified in initializer
> > arch/powerpc/kernel/of_platform.c:479: warning: initialization makes pointer from integer without a cast
> > make[1]: *** [arch/powerpc/kernel/of_platform.o] Blad 1
> > make: *** [arch/powerpc/kernel] Blad 2
> > 
> > I guess someone who knows multithread code should take a look at it.
> 
> Hrm. struct driver -> multithread_probe is gone in -mm ?
> 

yeah, it moved into struct bus_type.

http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/broken-out/driver-core-per-subsystem-multithreaded-probing.patch
