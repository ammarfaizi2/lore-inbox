Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277598AbRJHXYU>; Mon, 8 Oct 2001 19:24:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277600AbRJHXYB>; Mon, 8 Oct 2001 19:24:01 -0400
Received: from ns.suse.de ([213.95.15.193]:23305 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S277598AbRJHXXz>;
	Mon, 8 Oct 2001 19:23:55 -0400
Date: Tue, 9 Oct 2001 01:24:18 +0200 (CEST)
From: Dave Jones <davej@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "David S. Miller" <davem@redhat.com>, <dwmw2@infradead.org>,
        <frival@zk3.dec.com>, <paulus@samba.org>, <Martin.Bligh@us.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <jay.estabrook@compaq.com>, <rth@twiddle.net>
Subject: Re: [PATCH] change name of rep_nop
In-Reply-To: <E15qjdL-0002FT-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0110090120540.5479-100000@Appserv.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001, Alan Cox wrote:

> That raises the question of whether x86 should seperate the "386" "486" ..
> kernels by adding "Generic" for building a kernel that has all the work
> arounds for everyones randomly buggy processors

How do you propose to do this without turning setup.c and friends
into a #ifdef nightmare ? setup_intel.c, setup_amd.c etc ??

Some of the bits I've planned for setup.c in 2.5 will make this
look not so bad. Its grown quite large, and is continuing to do so
as more and more vendors make more and more hardware bugs for us
to work around.

Splitting out things like the memory detection to a seperate
file should bring this back down to a more sensible size.

regards,

Dave.

-- 
| Dave Jones.        http://www.suse.de/~davej
| SuSE Labs

