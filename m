Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264683AbSKDD2m>; Sun, 3 Nov 2002 22:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264764AbSKDD2m>; Sun, 3 Nov 2002 22:28:42 -0500
Received: from modemcable077.18-202-24.mtl.mc.videotron.ca ([24.202.18.77]:26892
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264683AbSKDD2l>; Sun, 3 Nov 2002 22:28:41 -0500
Date: Sun, 3 Nov 2002 22:36:26 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Robert Love <rml@tech9.net>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Pete Zaitcev <zaitcev@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: interrupt checks for spinlocks
In-Reply-To: <1036378887.750.96.camel@phantasy>
Message-ID: <Pine.LNX.4.44.0211032233070.14075-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 Nov 2002, Robert Love wrote:

> In other words, a lock unique to your interrupt handler does not need to
> disable interrupts (since only that handler can grab the lock and it is
> disabled).
> 
> If other handlers can grab the lock, interrupts need to be disabled.

The only way would be running with SA_INTERRUPT for that isr and any 
others on that line which might contend for the same lock. Determining 
otherwise seems like too much trouble, and anyway i can't recall ever 
seeing such a scenario in drivers/ Basically i think we should forget 
about option 1.

	Zwane
-- 
function.linuxpower.ca

