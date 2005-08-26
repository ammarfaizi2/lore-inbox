Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbVHZBQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbVHZBQR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 21:16:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbVHZBQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 21:16:17 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:14840 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S965037AbVHZBQR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 21:16:17 -0400
Subject: Re: 2.6.13-rc7-rt1
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: tglx@linutronix.de
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1125015724.20120.143.camel@tglx.tec.linutronix.de>
References: <20050825062651.GA26781@elte.hu>
	 <1125012596.14592.12.camel@dhcp153.mvista.com>
	 <1125015724.20120.143.camel@tglx.tec.linutronix.de>
Content-Type: text/plain
Organization: MontaVista
Date: Thu, 25 Aug 2005 18:15:44 -0700
Message-Id: <1125018945.14592.15.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-26 at 02:22 +0200, Thomas Gleixner wrote:
> On Thu, 2005-08-25 at 16:29 -0700, Daniel Walker wrote:
> > Devastating latency on a 3Ghz xeon .. Maybe the raw_spinlock in the
> > timer base is creating a unbounded latency?
> 
> The lock is only held for really short periods. The only possible long
> period would be migration of timers from a dead hotplug cpu to another.
> I guess thats not the case.
> 
> Do you have HIGH_RES_TIMERS enabled ?

No. The cascade has a very long worst case.

Daniel

