Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286338AbRL2V7E>; Sat, 29 Dec 2001 16:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286330AbRL2V6y>; Sat, 29 Dec 2001 16:58:54 -0500
Received: from waste.org ([209.173.204.2]:11221 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S286708AbRL2V6p>;
	Sat, 29 Dec 2001 16:58:45 -0500
Date: Sat, 29 Dec 2001 15:58:42 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC, CFT] include file cleanup
In-Reply-To: <200112291823.fBTINBb29439@colorfullife.com>
Message-ID: <Pine.LNX.4.43.0112291552080.18183-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Dec 2001, Manfred Spraul wrote:

> slab.h is currently one of the worst include files:
> it includes <mm.h>, that one <sched.h>, that one <fs.h>,
> just because it needs the GFP_ defines.
>
> I've split the gfp functions out of mm.h into a seperate <gfp.h>
> header file.
>
> Is that a step in the right direction?

Maybe. You might want to pull the rest of the get_free_page functions
out with it.

> Another similar cleanup would be  splitting the 'struct task_struct'
> definition out of sched.h into a seperate <linux/current.h>:
> some source files only include sched.h because they dereference
> one field within current.

Tried it yet? I think you'll find this very difficult because of all the
things task_struct references.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

