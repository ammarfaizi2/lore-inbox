Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286933AbRL2WTP>; Sat, 29 Dec 2001 17:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286794AbRL2WTE>; Sat, 29 Dec 2001 17:19:04 -0500
Received: from colorfullife.com ([216.156.138.34]:31241 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S286933AbRL2WSx>;
	Sat, 29 Dec 2001 17:18:53 -0500
Message-ID: <3C2E4158.93ACFFA3@colorfullife.com>
Date: Sat, 29 Dec 2001 23:19:04 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.1-dj6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC, CFT] include file cleanup
In-Reply-To: <Pine.LNX.4.43.0112291552080.18183-100000@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
> 
> Maybe. You might want to pull the rest of the get_free_page functions
> out with it.

Yes, I overlooked them. Thanks.

> 
> > Another similar cleanup would be  splitting the 'struct task_struct'
> > definition out of sched.h into a seperate <linux/current.h>:
> > some source files only include sched.h because they dereference
> > one field within current.
> 
> Tried it yet? I think you'll find this very difficult because of all the
> things task_struct references.
>
It wasn't that difficult: only these includes are needed to pull in all
substructures ;-)

<<<<<<<
#include <linux/config.h>
#include <linux/types.h>
#include <linux/spinlock.h>
#include <linux/list.h>
#include <linux/wait.h>
#include <linux/timer.h>
#include <linux/times.h>
#include <linux/capability.h>
#include <linux/resource.h>
#include <linux/signal.h>
#include <asm/param.h>
#include <asm/signal.h>
#include <asm/processor.h>
#include <asm/resource.h>
<<<<<<<<<

Another target is IS_ERR: several header files include fs.h because they
need it.
--
	Manfred
