Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbQLSWtn>; Tue, 19 Dec 2000 17:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129810AbQLSWte>; Tue, 19 Dec 2000 17:49:34 -0500
Received: from [213.237.20.108] ([213.237.20.108]:24174 "EHLO ns.geekboy.dk")
	by vger.kernel.org with ESMTP id <S129669AbQLSWtT>;
	Tue, 19 Dec 2000 17:49:19 -0500
Date: Tue, 19 Dec 2000 23:23:46 +0100
From: Torben Mathiasen <torben@kernel.dk>
To: Rasmus Andersen <rasmus@jaquet.dk>
Cc: Francois Romieu <romieu@cogenit.fr>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Converting drivers/net/rcpci45.c to new PCI API
Message-ID: <20001219232346.A1705@torben>
In-Reply-To: <20001219004604.B761@jaquet.dk> <20001219095906.A5764@se1.cogenit.fr> <20001219220530.A1643@torben> <20001219224904.D639@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001219224904.D639@jaquet.dk>; from rasmus@jaquet.dk on Tue, Dec 19, 2000 at 10:49:04PM +0100
X-OS: Linux 2.4.0-test13-pre2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19 2000, Rasmus Andersen wrote:
> On Tue, Dec 19, 2000 at 10:05:30PM +0100, Torben Mathiasen wrote:
> > 
> > You should release the irq when the adapter is closed, not removed,
> > unless there's some special case that can't be handled if you take
> > ints during init.
> 
> You seem to be right. I have moved the free_irq to the close function.
>

This driver seems a bit odd. It also request irq's durint init instead
of device open. Normally one would request any resource as late as
possible (to prevent the driver from using resources when it is
not even used). It makes one wonder if this driver has just not
been updated in a while, or if it does things for a reason.


-- 
Torben Mathiasen <torben@kernel.dk>
Linux ThunderLAN maintainer 
http://tlan.kernel.dk
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
