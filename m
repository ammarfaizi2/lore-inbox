Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263887AbTEOGKl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 02:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263891AbTEOGKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 02:10:40 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:16770
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263887AbTEOGK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 02:10:26 -0400
Date: Thu, 15 May 2003 02:13:45 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrew Morton <akpm@digeo.com>
cc: Patrick Mochel <mochel@osdl.org>, "" <linux-kernel@vger.kernel.org>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: 2.5.69-mm5: reverting i8259-shutdown.patch
In-Reply-To: <20030514231414.42398dda.akpm@digeo.com>
Message-ID: <Pine.LNX.4.50.0305150207070.19782-100000@montezuma.mastecende.com>
References: <20030514193300.58645206.akpm@digeo.com>
 <Pine.LNX.4.44.0305141935440.9816-100000@cherise> <20030514231414.42398dda.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003, Andrew Morton wrote:

> I'd say that as long as the shutdown routines are executed in reverse
> order of startup, then the core driver stuff has fulfilled its
> obligations.
> 
> In this case we need to understand why the lockup is happening - what
> code is requiring 8259 services after the thing has been turned off?
> Could be that the bug lies there.

The registration is somewhat unfair here, it depends on device_initcall 
and we initialise the 8259 in init_IRQ.

	Zwane
-- 
function.linuxpower.ca
