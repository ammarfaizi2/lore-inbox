Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbTE0Coq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 22:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbTE0Coq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 22:44:46 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:30595
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S262524AbTE0Cop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 22:44:45 -0400
Date: Mon, 26 May 2003 22:45:20 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Morton <akpm@digeo.com>, "" <davem@redhat.com>, "" <andrea@suse.de>,
       "" <davidsen@tmr.com>, "" <haveblue@us.ibm.com>,
       "" <habanero@us.ibm.com>, "" <mbligh@aracnet.com>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: userspace irq balancer
In-Reply-To: <20030527024419.GF8978@holomorphy.com>
Message-ID: <Pine.LNX.4.50.0305262241520.2265-100000@montezuma.mastecende.com>
References: <20030527000639.GA3767@dualathlon.random>
 <20030526.171527.35691510.davem@redhat.com> <20030527004115.GD3767@dualathlon.random>
 <20030526.174841.116378513.davem@redhat.com> <20030527015307.GC8978@holomorphy.com>
 <20030526185920.64e9751f.akpm@digeo.com> <20030527021002.GD8978@holomorphy.com>
 <Pine.LNX.4.50.0305262212070.2265-100000@montezuma.mastecende.com>
 <20030527024419.GF8978@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 May 2003, William Lee Irwin III wrote:

> On Mon, May 26, 2003 at 10:15:23PM -0400, Zwane Mwaikambo wrote:
> > Ok there are 16 IOAPICs on an 8quad, but really if we start banging on 
> > that lock someone is doing way too much hardware access...
> 
> It's done to acknowledge every interrupt. Also, there is additional
> cost associated with bouncing the lock's cacheline.

Bah, determining owning ioapic of an irq would get too ugly, you can have 
the same irq connected to multiple ioapics so which to lock?

	Zwane
-- 
function.linuxpower.ca
