Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278120AbRJaAa1>; Tue, 30 Oct 2001 19:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278103AbRJaAaP>; Tue, 30 Oct 2001 19:30:15 -0500
Received: from t02-22.ra.uc.edu ([129.137.228.46]:44933 "EHLO cartman")
	by vger.kernel.org with ESMTP id <S278189AbRJaAaJ>;
	Tue, 30 Oct 2001 19:30:09 -0500
Date: Tue, 30 Oct 2001 19:30:10 -0500
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 8139too thread termination
Message-ID: <20011030193010.B898@cartman>
In-Reply-To: <20011029232508.A305@cartman> <20011030191152.A898@cartman> <3BDF436A.AE664A99@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BDF436A.AE664A99@mandrakesoft.com>
User-Agent: Mutt/1.3.23i
From: Robert Kuebel <kuebelr@email.uc.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i was so wrapped up in digging through kmalloc(), that i missed the
memset() in alloc_netdev().  duh!

On Tue, Oct 30, 2001 at 07:18:50PM -0500, Jeff Garzik wrote:
> Robert Kuebel wrote:
> > 
> > ok, i am wondering if i have made a mistake.  this patch will make the
> > kernel thread die when tp->time_to_die is true.  tp is kmalloc()'ed
> > inside of alloc_etherdev.  i didn't initialize time_to_die to 0, but
> > this patch has been working perfectly for me.  am i just lucky or are
> > kmalloc()'ed regions zero'ed out?
> 
> And here I thought you did it on purpose :)
> 
> alloc_etherdev zeroes memory it allocates, so in net drivers all private
> structures can be considered initialized to zero when you get them.
> 
> 	Jeff
> 
> 
> -- 
> Jeff Garzik      | Only so many songs can be sung
> Building 1024    | with two lips, two lungs, and one tongue.
> MandrakeSoft     |         - nomeansno
