Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268800AbUHUBEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268800AbUHUBEa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 21:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268785AbUHUBEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 21:04:30 -0400
Received: from gate.crashing.org ([63.228.1.57]:40337 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268800AbUHUBEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 21:04:13 -0400
Subject: Re: SMP cpu deep sleep
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wes Felter <wmf@austin.ibm.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <pan.2004.08.20.16.44.39.888193@austin.ibm.com>
References: <1092989207.18275.14.camel@linux.local>
	 <pan.2004.08.20.16.44.39.888193@austin.ibm.com>
Content-Type: text/plain
Message-Id: <1093049624.9932.262.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 21 Aug 2004 10:53:45 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-21 at 02:44, Wes Felter wrote:

> The CPU hotplug patch is the way to go, but the hardware is the problem. I
> talked to an Intel CPU architect at MICRO last year and he confirmed that
> SMP Intel systems don't support any low-power modes besides HLT. AMD's
> documentation says that Opterons support voltage/frequency scaling (aka
> Cool 'n' Quiet), but AFAICT the documentation is wrong. In summary, you
> are doomed.

Well, with intel CPUs maybe ;) On PPC we can put some CPUs (at least the
desktop ones and the 970, I don't know about POWER3/4/5) into SLEEP mode
after flushing all caches & masking all IRQs to them, and get them out
via an IPI, or we can mask EE as well and get them out via a soft reset
if we have access to it.

Ben.


