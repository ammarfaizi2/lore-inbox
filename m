Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbUKDEzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbUKDEzi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 23:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbUKDEzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 23:55:38 -0500
Received: from ozlabs.org ([203.10.76.45]:38105 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262068AbUKDEzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 23:55:32 -0500
Subject: Re: [PATCH] [CPU-HOTPLUG] convert cpucontrol to be a rwsem
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dominik Brodowski <linux@dominikbrodowski.de>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041102222819.GA16414@dominikbrodowski.de>
References: <20041101084337.GA7824@dominikbrodowski.de>
	 <Pine.LNX.4.61.0411010656380.19123@musoma.fsmlabs.com>
	 <20041102222819.GA16414@dominikbrodowski.de>
Content-Type: text/plain
Date: Thu, 04 Nov 2004 12:57:17 +1100
Message-Id: <1099533437.7143.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-02 at 23:28 +0100, Dominik Brodowski wrote:
> Except that we don't want to (and can't[*]) disable preemption in the
> cpufreq case. Therefore, we __need__ to disable CPU hotplug specifically,
> and not meddle with other issues like preemption, scheduling, CPUs which are
> in the allowed_map, and so on. So back to the original patch: Rusty, do you
> agree with it?

Sure.  I consider it a trivial change.  The reason it wasn't a rwsem in
the first place is that there weren't many places which needed to grab
it, and none were time-sensitive.

Thanks!
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

