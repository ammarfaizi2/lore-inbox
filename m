Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130796AbRCFAHd>; Mon, 5 Mar 2001 19:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130793AbRCFAHX>; Mon, 5 Mar 2001 19:07:23 -0500
Received: from mail2.mail.iol.ie ([194.125.2.193]:12804 "EHLO mail.iol.ie")
	by vger.kernel.org with ESMTP id <S130792AbRCFAHE>;
	Mon, 5 Mar 2001 19:07:04 -0500
Date: Tue, 6 Mar 2001 00:06:52 +0000
From: Kenn Humborg <kenn@linux.ie>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kmalloc() alignment
Message-ID: <20010306000652.A13992@excalibur.research.wombat.ie>
In-Reply-To: <3AA2C488.54A792AD@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AA2C488.54A792AD@colorfullife.com>; from manfred@colorfullife.com on Sun, Mar 04, 2001 at 11:41:12PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 04, 2001 at 11:41:12PM +0100, Manfred Spraul wrote:
> >
> > Does kmalloc() make any guarantees of the alignment of allocated 
> > blocks? Will the returned block always be 4-, 8- or 16-byte 
> > aligned, for example? 
> >
> 
> 4-byte alignment is guaranteed on 32-bit cpus, 8-byte alignment on
> 64-bit cpus.

So, to summarise (for 32-bit CPUs):

o  Alan Cox & Manfred Spraul say 4-byte alignment is guaranteed.

o  If you need larger alignment, you need to alloc a larger space,
   round as necessary, and keep the original pointer for kfree()

Maybe I'll just use get_free_pages, since it's a 64KB chunk that
I need (and it's only a once-off).

Thanks for your advice.

Later,
Kenn

