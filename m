Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291882AbSBARur>; Fri, 1 Feb 2002 12:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291883AbSBARu2>; Fri, 1 Feb 2002 12:50:28 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:38819 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S291882AbSBARuX>;
	Fri, 1 Feb 2002 12:50:23 -0500
Date: Fri, 1 Feb 2002 12:50:20 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Christoph Hellwig <hch@caldera.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] kthread abstraction
Message-ID: <20020201125020.A25010@havoc.gtf.org>
In-Reply-To: <20020201163818.A32551@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020201163818.A32551@caldera.de>; from hch@caldera.de on Fri, Feb 01, 2002 at 04:38:19PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2002 at 04:38:19PM +0100, Christoph Hellwig wrote:
>     void (*main)(struct kthread *);
> 
> 	Mainloop of the thread.  This loop is repeated until the thread
> 	is stopped.  After finishing this method the common code calls
> 	schedule() so it's no allowed to have spinlocks held over more
> 	than one invocation.

Seems kinda nifty so far.  The only comment is that I wouldn't call
schedule or anything like that.  Give the thread the flexibility to
decide how it sleeps or loops.  Duplicating schedule() calls is IMHO an
ok price to pay for this flexibility.

	Jeff



