Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287221AbRL2W3h>; Sat, 29 Dec 2001 17:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286794AbRL2W21>; Sat, 29 Dec 2001 17:28:27 -0500
Received: from waste.org ([209.173.204.2]:39125 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S287215AbRL2W2J>;
	Sat, 29 Dec 2001 17:28:09 -0500
Date: Sat, 29 Dec 2001 16:28:06 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC, CFT] include file cleanup
In-Reply-To: <3C2E4158.93ACFFA3@colorfullife.com>
Message-ID: <Pine.LNX.4.43.0112291625340.18183-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, Manfred Spraul wrote:

> It wasn't that difficult: only these includes are needed to pull in all
> substructures ;-)
>
> <<<<<<<
> #include <linux/config.h>
> #include <linux/types.h>
> #include <linux/spinlock.h>
> #include <linux/list.h>
> #include <linux/wait.h>
> #include <linux/timer.h>
> #include <linux/times.h>
> #include <linux/capability.h>
> #include <linux/resource.h>
> #include <linux/signal.h>
> #include <asm/param.h>
> #include <asm/signal.h>
> #include <asm/processor.h>
> #include <asm/resource.h>
> <<<<<<<<<

Indeed. Recently I wanted to stash current->pid inside a spinlock for
debugging purposes and discovered it was a nightmare because of all the
forward references that'd be needed.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

