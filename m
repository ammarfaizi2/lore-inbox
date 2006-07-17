Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbWGQQCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbWGQQCn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbWGQQCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:02:43 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:20239 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750909AbWGQQCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:02:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bBwni5zm9S6aVpPhdYGTIsqjltvUJ0GfbOD79zXICo1YSCq85VHHILk1HX7Z9KYGGjQ35LbnAy2IeorgS9dOAD/jsdMXSnCS54m4BjtksPjm6rNnvq49XI7P6X6K8wKxd3gdNBj1ueeEDQ9wy+PMlfuWl7Y34TdfM5219t9ZC8U=
Message-ID: <f96157c40607170902l47849e42qc4f1c64087a236d8@mail.gmail.com>
Date: Mon, 17 Jul 2006 16:02:36 +0000
From: "gmu 2k6" <gmu2006@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Re: i686 hang on boot in userspace
In-Reply-To: <f96157c40607170858o567abe24r5d9bdd4895a906c9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060714150418.120680@gmx.net>
	 <Pine.LNX.4.64.0607171242440.6761@scrub.home>
	 <20060717133809.150390@gmx.net>
	 <Pine.LNX.4.64.0607171605500.6761@scrub.home>
	 <f96157c40607170759p1ab37abdi88d178c3503fb2e1@mail.gmail.com>
	 <Pine.LNX.4.64.0607171718140.6762@scrub.home>
	 <f96157c40607170858o567abe24r5d9bdd4895a906c9@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/06, gmu 2k6 <gmu2006@gmail.com> wrote:
> On 7/17/06, Roman Zippel <zippel@linux-m68k.org> wrote:
> > Hi,
> >
> > On Mon, 17 Jul 2006, gmu 2k6 wrote:
> >
> > > I was preparing a post to lkml about a similar hang which happens
> > > during init. I also saw an error while ntpdate tried to set the
> > > time/get the time. this only happens after I've enabled the NX bit on
> > > the dual 32bit Xeons installed in the HP Proliant Server. it works
> > > flawlessly with 2.6.17.6 (CONFIG_X86_PAE and CONFIG_HIGHMEM_64) but
> > > since 2.6.18-rc2-git4 (including 2.6.18-rc2) it hangs late in the init
> > > process.
> > >
> > > could this be related?
> >
> > Well, it could, but without further information it's impossible to say.
> > What error did you see with ntpdate? Could you post the kernel messages
> > and also insert a few stack traces as mentioned earlier?
> > Thanks.
>
> ok, the error printed from ntpdate has to do with networking:
> Running ntpdate to synchronize clockError : Temporary failure in name resolution
>
> it then stops after printing the following tg3 initialization line:
> tg3: eth0 Flow control is on for TX and on for RX.
>
> right now I'm trying to get SysRq working (my first try with it) so
> that I see where it's hanging.

either I'm too dumb or there is an undocumented way to enable SysRq on
bootup or the machine is really hanging hard. I'm not able use
Alt+Print as nothing happens besides console showing the typed in
characters ^[t.
