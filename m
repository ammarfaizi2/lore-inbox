Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137078AbREKIhK>; Fri, 11 May 2001 04:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137076AbREKIhA>; Fri, 11 May 2001 04:37:00 -0400
Received: from ns.suse.de ([213.95.15.193]:39429 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S137078AbREKIgu>;
	Fri, 11 May 2001 04:36:50 -0400
Date: Fri, 11 May 2001 10:36:40 +0200
From: Andi Kleen <ak@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andi Kleen <ak@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Ulrich.Weigand@de.ibm.com, linux-kernel@vger.kernel.org,
        schwidefsky@de.ibm.com
Subject: Re: Deadlock in 2.2 sock_alloc_send_skb?
Message-ID: <20010511103640.A2454@gruyere.muc.suse.de>
In-Reply-To: <C1256A48.00451BD1.00@d12mta11.de.ibm.com> <E14xq0v-0004j0-00@the-village.bc.nu> <20010510193047.A22970@gruyere.muc.suse.de> <20010510231300.W848@athlon.random> <20010510231717.A25610@gruyere.muc.suse.de> <20010510233225.Y848@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010510233225.Y848@athlon.random>; from andrea@suse.de on Thu, May 10, 2001 at 11:32:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2001 at 11:32:25PM +0200, Andrea Arcangeli wrote:
> you said interrupt won't call that function so I don't see the
> GFP_ATOMIC issue.

I said interrupts should not call it, but apparently somebody tries to 
call it with GFP_ATOMIC and I'm suspecting that caller is broken (whatever
it is, I don't think it is in the main tree)

> 
> I also don't what's the issue with GFP_ATOMIC regardless somebody uses

[...]

No argument about that it should handle oom anyways.



-Andi

