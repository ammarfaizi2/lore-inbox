Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbUK1V6X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbUK1V6X (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 16:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbUK1V6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 16:58:23 -0500
Received: from ozlabs.org ([203.10.76.45]:54204 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261458AbUK1V6S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 16:58:18 -0500
Subject: Re: [PPC64] Tweaks to ppc64 cpu sysfs information
From: Rusty Russell <rusty@rustcorp.com.au>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       Paul Mackerras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linuxppc64-dev@ozlabs.org,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041126035959.GK11370@zax>
References: <20041126035959.GK11370@zax>
Content-Type: text/plain
Date: Mon, 29 Nov 2004 08:58:11 +1100
Message-Id: <1101679091.25347.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-26 at 14:59 +1100, David Gibson wrote:
> Andrew, please apply:
> 
> Currently the ppc64 sysfs code registers an entry for each possible
> cpu in sysfs, rather than just online cpus.  That makes sense, since
> the sysfs entries are needed to control onlining of the cpus.
> However, this is done even if CONFIG_HOTPLUG_CPU is not set, or if it
> is not a hotplug capable (DLPAR) machine, which is a bit misleading.
> Secondly it also registers all the other sysfs entries (mostly
> performance monitoring controls) on all possible cpus, although they
> are quite meaningless on non-online cpus.

Surely if !CONFIG_HOTPLUG_CPU, then online == possible?  If not, it
should be.  That would solve part of the problem.

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

