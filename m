Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268324AbTCCE1B>; Sun, 2 Mar 2003 23:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268328AbTCCE1B>; Sun, 2 Mar 2003 23:27:01 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:1734
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268324AbTCCE1A>; Sun, 2 Mar 2003 23:27:00 -0500
Date: Sun, 2 Mar 2003 23:35:27 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5][CHECKER] rtc locking
In-Reply-To: <20030303042725.GN1195@holomorphy.com>
Message-ID: <Pine.LNX.4.50.0303022333200.25240-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.50.0303022317390.25240-100000@montezuma.mastecende.com>
 <20030303042725.GN1195@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Mar 2003, William Lee Irwin III wrote:

> On Sun, Mar 02, 2003 at 11:19:57PM -0500, Zwane Mwaikambo wrote:
> > Index: linux-2.5.62-numaq/drivers/char/rtc.c
> [... good patch]
> 
> Do you think some kind of API safety (e.g. removing *_lock_irq() in
> favor of *_lock_irqsave()) would be worthwhile for catching these kinds
> of errors?

I think it may be worth checking *_lock_irq users period, however iirc 
there is a speed argument wrt using _lock_irq since we don't save flags.

	Zwane
-- 
function.linuxpower.ca
