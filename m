Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136049AbRAJTtT>; Wed, 10 Jan 2001 14:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135889AbRAJTtJ>; Wed, 10 Jan 2001 14:49:09 -0500
Received: from Cantor.suse.de ([194.112.123.193]:64261 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S136049AbRAJTs7>;
	Wed, 10 Jan 2001 14:48:59 -0500
Date: Wed, 10 Jan 2001 20:48:56 +0100
From: Andi Kleen <ak@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>, Trond Myklebust <trond.myklebust@fys.uio.no>,
        Daniel Phillips <phillips@innominate.de>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug
Message-ID: <20010110204856.A5443@gruyere.muc.suse.de>
In-Reply-To: <20010110204308.A5303@gruyere.muc.suse.de> <E14GRE7-0000p5-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14GRE7-0000p5-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Jan 10, 2001 at 07:48:04PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, 2001 at 07:48:04PM +0000, Alan Cox wrote:
> > As the thread started it's not only only needed for pthreads, but also for NFS
> > and setuid (actually NFS already implements it privately), and probably other network
> > file systems too.  So it's far from being only a "bad standard corner case". 
> 
> I wonder how Linux 2.2 worked, that doesnt have them. Now if its a clean way
> of sorting out a pile of other things and it does pthreads as a side effect

Linux 2.2 setuid in nfs never worked quite like traditional Unix, and there
were lots of reports because users were regularly rediscovering it.

I think the nfs patches merged in 2.2.18 fixed it (?) 

> I've no problem, but arguing for it because of a tiny pthreads corner case
> is coming from the wrong end

I'm not so sure the thread corner case is that tiny. 

-Andi

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
