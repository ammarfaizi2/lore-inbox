Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271745AbRHQXIX>; Fri, 17 Aug 2001 19:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271747AbRHQXIN>; Fri, 17 Aug 2001 19:08:13 -0400
Received: from nef.ens.fr ([129.199.96.32]:22020 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S271745AbRHQXIC>;
	Fri, 17 Aug 2001 19:08:02 -0400
Date: Sat, 18 Aug 2001 01:08:10 +0200
From: David Madore <david.madore@ens.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: broken memory chip -> software fix?
Message-ID: <20010818010810.A6422@clipper.ens.fr>
In-Reply-To: <20010817161505.A25194@clipper.ens.fr> <E15XkYl-0007OT-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15XkYl-0007OT-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Aug 17, 2001 at 03:25:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2001 at 03:25:15PM +0100, Alan Cox wrote:
> > Now that I know the address, is there a way I can prevent Linux from
> > using that region of memory in any way?  The simplest and cleanest
> 
> Yep. The mem= option can exclude stuff. Alternatively you can
> patch arch/i386/kernel/mm/init.c:mem_init() to skip that page. 

Thanks.  The mem= option works perfectly:

	mem=78184k@1024k mem=313988k@79212k

will avoid the incriminated page.

Thanks also to those who pointed out the mmap() procedure: that will
let toy with the page in question - after all, a defective memory chip
is a fun thing to play with.

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.eleves.ens.fr:8080/home/madore/ )
