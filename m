Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317012AbSFQU6E>; Mon, 17 Jun 2002 16:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317013AbSFQU6E>; Mon, 17 Jun 2002 16:58:04 -0400
Received: from air-2.osdl.org ([65.172.181.6]:17793 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317012AbSFQU6C>;
	Mon, 17 Jun 2002 16:58:02 -0400
Date: Mon, 17 Jun 2002 13:57:44 -0700
From: Bob Miller <rem@osdl.org>
To: Dave Jones <davej@suse.de>, Benjamin LaHaise <bcrl@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v2.5.22 - add wait queue function callback support
Message-ID: <20020617135744.A24347@doc.pdx.osdl.net>
References: <20020617161434.D1457@redhat.com> <20020617222812.I758@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020617222812.I758@suse.de>; from davej@suse.de on Mon, Jun 17, 2002 at 10:28:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2002 at 10:28:12PM +0200, Dave Jones wrote:
> On Mon, Jun 17, 2002 at 04:14:34PM -0400, Benjamin LaHaise wrote:
>  > +#define add_wait_queue_cond(q, wait, cond) \
>  > +	({							\
>  > +		unsigned long flags;				\
>  > +		int _raced = 0;					\
>  > +		wq_write_lock_irqsave(&(q)->lock, flags);	\
> 
> I thought we killed off wq_write_lock_irqsave 1-2 kernels ago ?
> 
>         Dave
> 
> -- 
> | Dave Jones.        http://www.codemonkey.org.uk
> | SuSE Labs
> -

Dave,

It depends on what you mean by killed off.  I submitted a patch to Linus back
at 2.5.3 to clean up the way the completion code called the wait queue
interface.  This interface got added then.  You picked up those changes at
that time (and still have them in your kernel tree) but the changes have
never made it into Linus' tree.

So, Linus has never had the code to 'kill' and you've never dropped it
after picking it up.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
