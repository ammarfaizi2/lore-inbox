Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316070AbSGRHiv>; Thu, 18 Jul 2002 03:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316847AbSGRHiv>; Thu, 18 Jul 2002 03:38:51 -0400
Received: from slider.rack66.net ([212.3.252.135]:61456 "EHLO
	slider.rack66.net") by vger.kernel.org with ESMTP
	id <S316070AbSGRHit>; Thu, 18 Jul 2002 03:38:49 -0400
Date: Thu, 18 Jul 2002 09:42:30 +0200
From: Filip Van Raemdonck <filipvr@xs4all.be>
To: "Juergen E. Fischer" <fischer@linux-buechse.de>
Cc: Martin Diehl <lists@mdiehl.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] aha152x fix
Message-ID: <20020718074230.GD2155@debian>
Mail-Followup-To: "Juergen E. Fischer" <fischer@linux-buechse.de>,
	Martin Diehl <lists@mdiehl.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <1026860430.1688.95.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.21.0207170156360.6083-100000@notebook.diehl.home> <20020717213543.GA27707@debian> <20020718055204.GA10357@linux-buechse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020718055204.GA10357@linux-buechse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 07:52:04AM +0200, Juergen E. Fischer wrote:
> [I seem to have had a problem with my provider's smart host. It didn't
>  deliver to everyone.  Hopefully that's resolved now. Sorry
>  I you already seen this whole or in part.]

I have received your previous message, but only saw it after I sent mine.
(I read lkml from a different address than the one I send from, and only
check the mail received at the latter once a day)
And it appears your mail doesn't reach lkml anyway. ECN perhaps?

> On Wed, Jul 17, 2002 at 23:35:43 +0200, Filip Van Raemdonck wrote:
> > Actually, hold on...
> > I just rmmodded the aha152x module and then modprobe sd_mod and all was/is
> > fine now, except that obviously I can't get to my harddrive now - sd_mod is
> > just an unused driver.
> > 
> > I'm pasting an oops below.
> 
> Please run it through ksymoops (Documentation/oops-tracing.txt).

Can that be done with the ones already modified by klogd? Note that when I
talked about almost immediate hard crashes, I really meant that. Within a
second (or two or three at max) a number of new oopses are generated, ending
in a final one with the "killing interrupt handler" message. And these don't
even show up in the logs because the machine doesn't sync anymore at that
point.
I also don't have a serial cable handy.
But I'll see what I can do.

> +#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
> +		spin_unlock_irq(&io_request_lock);
> +#endif

Note that this is not really the issue (anymore). I did this already, and
basically just left out the #if. But now I'm getting oopses when I actually
try to use a drive attached to it - which is probably caused by another part
of the last driver change than this detect issue.


Regards,

Filip

-- 
<broonie> Why do all the idiots on debian-user insist on trying sendmail.
<Myth> because sendmail is "industry standard"
<broonie> Mind you, I suppose the industry standard is to be a fscking moron.
<Thing> broonie: tell them to fuck off and use M$ Exchange -- that's that
        market leader, surely?
