Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311885AbSHGU7Q>; Wed, 7 Aug 2002 16:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313711AbSHGU7J>; Wed, 7 Aug 2002 16:59:09 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:56075 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S313743AbSHGU7G>; Wed, 7 Aug 2002 16:59:06 -0400
Date: Wed, 7 Aug 2002 18:02:19 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Jesse Barnes <jbarnes@sgi.com>
cc: linux-kernel@vger.kernel.org, <jmacd@namesys.com>, <phillips@arcor.de>,
       <rml@tech9.net>
Subject: Re: [PATCH] lock assertion macros for 2.5.30
In-Reply-To: <20020807205134.GA27013@sgi.com>
Message-ID: <Pine.LNX.4.44L.0208071758280.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Aug 2002, Jesse Barnes wrote:

> +++ linux-2.5.30-lockassert/drivers/scsi/scsi.c Wed Aug  7 11:35:32 2002
> @@ -262,7 +262,7 @@

> +        MUST_NOT_HOLD(q->queue_lock);

...

> +#if defined(CONFIG_DEBUG_SPINLOCK) && defined(CONFIG_SMP)
> +#define MUST_HOLD(lock)			BUG_ON(!spin_is_locked(lock))
> +#define MUST_NOT_HOLD(lock)		BUG_ON(spin_is_locked(lock))

Please tell me the MUST_NOT_HOLD thing is a joke.

What is to prevent another CPU in another code path
from holding this spinlock when the code you've
inserted the MUST_NOT_HOLD in is on its merry way
not holding the lock ?

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/


