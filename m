Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbTEOHw4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 03:52:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTEOHw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 03:52:56 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:37506
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S262735AbTEOHwz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 03:52:55 -0400
Date: Thu, 15 May 2003 03:56:05 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrew Morton <akpm@digeo.com>
cc: Patrick Mochel <mochel@osdl.org>, "" <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: 2.5.69-mm5: reverting i8259-shutdown.patch
In-Reply-To: <Pine.LNX.4.50.0305150207070.19782-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0305150355210.19782-100000@montezuma.mastecende.com>
References: <20030514193300.58645206.akpm@digeo.com>
 <Pine.LNX.4.44.0305141935440.9816-100000@cherise> <20030514231414.42398dda.akpm@digeo.com>
 <Pine.LNX.4.50.0305150207070.19782-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 May 2003, Zwane Mwaikambo wrote:

> On Wed, 14 May 2003, Andrew Morton wrote:
> 
> > I'd say that as long as the shutdown routines are executed in reverse
> > order of startup, then the core driver stuff has fulfilled its
> > obligations.
> > 
> > In this case we need to understand why the lockup is happening - what
> > code is requiring 8259 services after the thing has been turned off?
> > Could be that the bug lies there.
> 
> The registration is somewhat unfair here, it depends on device_initcall 
> and we initialise the 8259 in init_IRQ.

Pat what do you say to some late shutdown callbacks? I'll drop you a 
patch sometime tommorrow.

	Zwane
-- 
function.linuxpower.ca
