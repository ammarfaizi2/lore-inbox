Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbVATE5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbVATE5x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 23:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbVATE5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 23:57:53 -0500
Received: from ozlabs.org ([203.10.76.45]:23697 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262050AbVATE5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 23:57:43 -0500
Subject: Re: [RFC][PATCH 3/4] use a rwsem for cpucontrol
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dominik Brodowski <linux@dominikbrodowski.de>
Cc: dhowells@redhat.com,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>
In-Reply-To: <20050119213847.GD8471@dominikbrodowski.de>
References: <20050119213847.GD8471@dominikbrodowski.de>
Content-Type: text/plain
Date: Thu, 20 Jan 2005 15:57:29 +1100
Message-Id: <1106197050.15476.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-19 at 22:38 +0100, Dominik Brodowski wrote:
> Currently, lock_cpu_hotplug serializes multiple calls to cpufreq->target()
> on multiple CPUs even though that's unnecessary. Even further, it
> serializes these calls with totally unrelated other parts of the kernel...
> some ppc64 event reporting, some cache management, and so on. In my opinion
> locking should be done subsystem (and normally data-)specific, and disabling
> CPU hotplug should just do that.

Sure.

Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

