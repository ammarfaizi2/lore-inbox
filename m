Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266323AbSLIXE4>; Mon, 9 Dec 2002 18:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266298AbSLIXE4>; Mon, 9 Dec 2002 18:04:56 -0500
Received: from air-2.osdl.org ([65.172.181.6]:22728 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S266323AbSLIXEz>;
	Mon, 9 Dec 2002 18:04:55 -0500
Subject: Re: [PATCH] aacraid 2.5
From: Mark Haverkamp <markh@osdl.org>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: Christoph Hellwig <hch@infradead.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <15861.4842.846748.181660@wombat.chubb.wattle.id.au>
References: <15861.4842.846748.181660@wombat.chubb.wattle.id.au>
Content-Type: text/plain
Organization: 
Message-Id: <1039475591.28638.31.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 09 Dec 2002 15:13:11 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-12-09 at 14:02, Peter Chubb wrote:
> >>>>> "Mark" == Mark Haverkamp <markh@osdl.org> writes:
> 
> Mark> On Fri, 2002-12-06 at 16:30, Christoph Hellwig wrote:
> >> On Fri, Dec 06, 2002 at 07:45:42AM -0800, Mark Haverkamp wrote: >
> >> +/** > + * Convert capacity to cylinders > + * accounting for the
> >> fact capacity could be a 64 bit value > + * > + */ > +static inline
> >> u32 cap_to_cyls(sector_t capacity, u32 divisor) > +{ > +#ifdef
> >> CONFIG_LBD > + do_div(capacity, divisor); > +#else > + capacity /=
> >> divisor; > +#endif > + return (u32) capacity; > +}
> >> 
> >> Please use sector_div() instead.  It exists for a reason.
> 
> 
> Mark> Thanks for finding this.  I have enclosed a change using your
> Mark> suggestion.
> 
> 
> sector_div(a, b) is just like do_div(a, b) -- it returns the
> remainder, and sets a to a/b which is not reflected in your patch...
> 

oops, I didn't look closely enough at the sector_div code.
-- 
Mark Haverkamp <markh@osdl.org>

