Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270682AbTHEUbp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 16:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270684AbTHEUbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 16:31:45 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:26338 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S270682AbTHEUbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 16:31:44 -0400
Date: Tue, 5 Aug 2003 20:31:37 +0000
From: Arjan van de Ven <arjanv@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andi Kleen <ak@colin2.muc.de>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Export touch_nmi_watchdog
Message-ID: <20030805203137.E30256@devserv.devel.redhat.com>
References: <1060114808.5308.9.camel@laptop.fenrus.com> <Pine.LNX.4.44.0308051324070.2587-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0308051324070.2587-100000@home.osdl.org>; from torvalds@osdl.org on Tue, Aug 05, 2003 at 01:25:09PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 05, 2003 at 01:25:09PM -0700, Linus Torvalds wrote:
> 
> On 5 Aug 2003, Arjan van de Ven wrote:
> > 
> > having a more generic/portable "trigger_watchdog" function would be
> > better then, such that ALL watchdogs, and not just the NMI one can hook
> > into this
> 
> Why are we working around broken drivers?
> 
> I say:
>  - either fix the driver
> or
>  - disable the watchdog entirely.
> 
> I don't see any point at all to touch_xxx_watchdog() from a driver.

In principle you are soooo right. Just that it sometimes is HARD to fix
such long delays... I remember working on the qla2x00 driver to fix that ;(
Ok "it's hard" is no excuse. 
