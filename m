Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317012AbSHGEpe>; Wed, 7 Aug 2002 00:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317022AbSHGEpe>; Wed, 7 Aug 2002 00:45:34 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:1259 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317012AbSHGEpd>;
	Wed, 7 Aug 2002 00:45:33 -0400
Date: Wed, 7 Aug 2002 10:29:49 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
       vamsi_krishna@in.ibm.com
Subject: Re: [PATCH] kprobes for 2.5.30
Message-ID: <20020807102949.A23745@in.ibm.com>
Reply-To: vamsi@in.ibm.com
References: <20020806164242.B22164@in.ibm.com> <20020807020259.70602418A@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020807020259.70602418A@lists.samba.org>; from rusty@rustcorp.com.au on Wed, Aug 07, 2002 at 10:55:04AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rusty,

On Wed, Aug 07, 2002 at 10:55:04AM +1000, Rusty Russell wrote:
> In message <20020806164242.B22164@in.ibm.com> you write:
> > - move trap1 and trap3 interrupt gates only under CONFIG_KPROBES. Please
> >   note that if we don't do this, we need to call restore_interrupts()
> >   from the dummy (post_)kprobe_handler() in include/asm-i386/kprobes.h
> >   when CONFIG_KPROBES is off. I didn't like this subtle side effect. hence
> >   the #ifdef CONFIG_KPROBES around _set_trap_gate. Still, the calling 
> >   conventions of do_debug and do_int3 remain independent of CONFIG_KPROBES.
> 
> Hmm, I thought about this but then decided against it.  Your way is
> pretty subtle too: I think I prefer the restore_interrupts()
> explicitly after the (failed) call to kprobe_handler, ie (on top of
> your patch, which looks excellent):

I agree this one is even better. 

Thanks,
Vamsi.

> <snip patch>

-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
