Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279370AbRKIFqD>; Fri, 9 Nov 2001 00:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279378AbRKIFpx>; Fri, 9 Nov 2001 00:45:53 -0500
Received: from ns.suse.de ([213.95.15.193]:12810 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S279370AbRKIFpp>;
	Fri, 9 Nov 2001 00:45:45 -0500
Date: Fri, 9 Nov 2001 06:45:40 +0100
From: Andi Kleen <ak@suse.de>
To: Anton Blanchard <anton@samba.org>
Cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
        linux-kernel@vger.kernel.org
Subject: Re: speed difference between using hard-linked and modular drives?
Message-ID: <20011109064540.A13498@wotan.suse.de>
In-Reply-To: <Pine.LNX.4.33.0111081802380.15975-100000@localhost.localdomain.suse.lists.linux.kernel> <Pine.LNX.4.33.0111081836080.15975-100000@localhost.localdomain.suse.lists.linux.kernel> <p731yj8kgvw.fsf@amdsim2.suse.de> <20011109110532.B6822@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20011109110532.B6822@krispykreme>; from anton@samba.org on Fri, Nov 09, 2001 at 11:05:32AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2001 at 11:05:32AM +1100, Anton Blanchard wrote:
> We also need a way to satisfy very large allocations for the hashes (eg
> the pagecache hash). On a 32G machine we get awful performance on the
> pagecache hash because we can only get an order 9 allocation out of
> get_free_pages:
> 
> http://samba.org/~anton/linux/pagecache/pagecache_before.png
> 
> When switching to vmalloc the hash is large enough to be useful:
> 
> http://samba.org/~anton/linux/pagecache/pagecache_after.png
> 
> As pointed out by Davem and Ingo we should try and avoid vmalloc here
> due to tlb trashing.

Sounds like you need a better hash function instead.

-Andi

