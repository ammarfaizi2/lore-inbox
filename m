Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266217AbUFRRaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266217AbUFRRaI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 13:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266289AbUFRRaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 13:30:08 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:1243 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S266217AbUFRR3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 13:29:53 -0400
To: davids@webmaster.com
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Using kernel headers that are not for the running kernel
References: <MDEHLPKNGKAHNMBLJOLKMECEMLAA.davids@webmaster.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Fri, 18 Jun 2004 15:25:37 +0200
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKMECEMLAA.davids@webmaster.com> (David
 Schwartz's message of "Thu, 17 Jun 2004 17:04:30 -0700")
Message-ID: <m3brjhdmlq.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David Schwartz" <davids@webmaster.com> writes:

> 	It creates a stable system. Things become much less stable if you mess
> around with all of userspace just because the kernel changes. There is no
> reason user space should be in sync with the running kernel. User space
> should be stable.

Kernel headers should and in fact are stable WRT common userspace
interface. If they aren't, you're forced to recompile the userspace
anyway.

BTW: it's ok to compile things like glibc against new kernel headers
(say, 2.6.x) and use the resulting library with older kernels (as old
as 2.2 I think). In fact it's the preferred way to compile glibc.
You can disable support for older kernels with glibc/configure
--enable-kernel=VERSION --enable-oldest-abi=ABI.

> The kernel-user interface is supposed to stay stable, so you shouldn't need
> to make significant user space changes when you upgrade the kernel. Only
> specific applications that need to get specific new features that require
> changes to the kernel-user interface need to change.

Sure. Examples: ioctls for configuring the system.

> It has been a very long
> time since compiling user space programs against the header files for the
> kernel you happened to be running was considered good practice.

I think at this point we have to create include/abi (or api) as a part
of the kernel. The mess with distributions-provided "glibc kernel
headers" must at last be cleaned.

Should no one have time for doing that I'm going to start.
-- 
Krzysztof Halasa, B*FH
