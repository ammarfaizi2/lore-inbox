Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030569AbWBHGky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030569AbWBHGky (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 01:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030570AbWBHGky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 01:40:54 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:17318 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030569AbWBHGky convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 01:40:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VBwX8eoIcGp+RKZh9F8F9srP5qcGNEdn+v6rayCPgTluxedWKkDOOSVQl8vVeh68mRAMeqA1p581uF445BpiKJlXZyoNp65ympaVZEiM6+C2LDylstu59Yi/L4H4TZPZoCNFRcx01joHIsdBz5zwddrTCpePa/PsCuAJNsGBKr8=
Message-ID: <d63eb2da0602072240t376e6312l3d6e7d7936024ee1@mail.gmail.com>
Date: Wed, 8 Feb 2006 12:10:53 +0530
From: Gaurav Dhiman <gauravd.chd@gmail.com>
To: anil dahiya <ak_ait@yahoo.com>
Subject: Re: Badness in sleep_on_timeout on kernel 2.6.9-1.667 ( fedora core 3)
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
In-Reply-To: <20060208055426.76961.qmail@web60215.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1139349028.3482.47.camel@pmac.infradead.org>
	 <20060208055426.76961.qmail@web60215.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/06, anil dahiya <ak_ait@yahoo.com> wrote:
> then which function i should use...beacause same
> problem is with interruptible_sleep_on

prefer to use wait_event_timeout() ; see its code in kernel.
Its written fro handling race conditions, which might occur in
interruptible_sleep_on() or other such functions.

-Gaurav

> thanks & Regards,
> anil
>
> --- David Woodhouse <dwmw2@infradead.org> wrote:
>
> > On Tue, 2006-02-07 at 12:00 -0800, anil dahiya
> > wrote:
> > >  Badness in sleep_on_timeout at
> > kernel/sched.c:3022
> > >  [<02302bc3>] sleep_on_timeout+0x5d/0x23a
> > >  [<0211b919>] default_wake_function+0x0/0xc
> > >
> > > can any suggest how i can avoid this oops.
> >
> > Stop using sleep_on_timeout(). It's almost certainly
> > buggy.
> >
> > --
> > dwmw2
> >
> >
> > --
> > Kernelnewbies: Help each other learn about the Linux
> > kernel.
> > Archive:
> > http://mail.nl.linux.org/kernelnewbies/
> > FAQ:           http://kernelnewbies.org/faq/
> >
> >
>
>
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com
>
> --
> Kernelnewbies: Help each other learn about the Linux kernel.
> Archive:       http://mail.nl.linux.org/kernelnewbies/
> FAQ:           http://kernelnewbies.org/faq/
>
>
