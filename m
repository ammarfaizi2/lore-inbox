Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274426AbRJEXHQ>; Fri, 5 Oct 2001 19:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274424AbRJEXHG>; Fri, 5 Oct 2001 19:07:06 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:9482 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S274351AbRJEXG7>;
	Fri, 5 Oct 2001 19:06:59 -0400
Date: Sat, 6 Oct 2001 01:07:25 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Etienne Lorrain <etienne_lorrain@yahoo.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New Input PS/2 driver
Message-ID: <20011006010725.A18843@suse.cz>
In-Reply-To: <20011006005006.A17152@suse.cz> <Pine.LNX.4.10.10110051558000.31239-100000@transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10110051558000.31239-100000@transvirtual.com>; from jsimmons@transvirtual.com on Fri, Oct 05, 2001 at 04:02:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2001 at 04:02:08PM -0700, James Simmons wrote:
> 
> > > Not implemented yet.
> > 
> > Quite the opposite: #undef was forgotten in the .h file after the .c
> > file converted to a runtime option instead of a compiletime one. I
> > removed it in the CVS now.
> 
>   Okay. Another thing is how to deal with IRQ's and the port regions. This
> can vary from platform to platform. We could have this as a command line
> option as well. In fact we might since it can be built as a module. Alot
> of platforms added things to the command line inside the kernel code.
>   Or we can do lots of #ifdef in i8042.h or using the asm/keyboard method
> like now. Personally I don't like this method since even on mips the i8042
> port range varies on different machines. So we still end up with a bunch
> of messy #ifdef. 

I'd prefer a bunch of #ifdefs in i8042.h with defaults and a command
line option to change that if needed. For some of the more differing
architectures (Sun Ultra AX) which have i8042-alike chips in them
complete separate drivers may make sense as well.


-- 
Vojtech Pavlik
SuSE Labs
