Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315279AbSILLnj>; Thu, 12 Sep 2002 07:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315413AbSILLnj>; Thu, 12 Sep 2002 07:43:39 -0400
Received: from gargantua.enseirb.fr ([147.210.18.6]:62882 "EHLO
	gargantua.enseirb.fr") by vger.kernel.org with ESMTP
	id <S315279AbSILLnj>; Thu, 12 Sep 2002 07:43:39 -0400
Date: Thu, 12 Sep 2002 13:48:00 +0200
From: lists@corewars.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrea Arcangeli <andrea@suse.de>, riel@conectiva.com.br,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 OOPS [Repost]
Message-ID: <20020912134800.A1068@corewars.org>
References: <20020903190726.A15065@corewars.org> <20020904201155.A17544@corewars.org> <20020904182223.GE1210@dualathlon.random> <20020905223233.A3893@corewars.org> <20020911191614.A2078@corewars.org> <1031766496.5832.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1031766496.5832.5.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Sep 11, 2002 at 06:48:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hm, actually I am.

And from the oops traces, the offending intruction always seems to be a
pop.

I'll upgrade and try again.

Thanks,
Sapan

On Wed, Sep 11, 2002 at 06:48:16PM +0100, Alan Cox wrote:
> On Wed, 2002-09-11 at 18:16, lists@corewars.org wrote:
> > Just in case this might shed some more light on the problem...
> > I recompiled the kernel with frame pointers about a week ago, and I
> > didn't face a single oops till today morning, when I recompiled the
> > kernel without frame-pointers and I've been getting the same
> > oopses all day.
> > 
> 
> Are you using gcc 3.0.x or an early gcc 3.1.x. There are bugs in those
> where they write below the stack pointer which means an IRQ will corrupt
> stuff. Turning on frame pointers might well hide this
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
