Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbVCaSaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbVCaSaD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 13:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbVCaS3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 13:29:39 -0500
Received: from wproxy.gmail.com ([64.233.184.192]:58440 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262023AbVCaS3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 13:29:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=VcN1kmxVXEyhrJKtLBxNUISFvnlhevCAkoP23n9LahJMVo6FzeeuI2DXMZBG2iRr1fDEIKoTOEwp2K7HAhEJ6nrWsArmSLMEgzV4/H7tD7k5Min6CyktB/vQfos9URJ1Y1TrFg/nLMu+KS4cc5tESAYhKDO9kVuf3QZgbdea2tU=
Message-ID: <40f323d005033110292934aa1d@mail.gmail.com>
Date: Thu, 31 Mar 2005 13:29:17 -0500
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
To: romano@dea.icai.upco.es, dtor_core@ameritech.net,
       Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc1 swsusp broken [Was Re: swsusp not working for me on a PREEMPT 2.6.12-rc1 and 2.6.12-rc1-mm3 kernel]
In-Reply-To: <20050331165007.GA29674@pern.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050329110309.GA17744@pern.dea.icai.upco.es>
	 <20050329132022.GA26553@pern.dea.icai.upco.es>
	 <20050329170238.GA8077@pern.dea.icai.upco.es>
	 <20050329181551.GA8125@elf.ucw.cz>
	 <20050331144728.GA21883@pern.dea.icai.upco.es>
	 <d120d5000503310715cbc917@mail.gmail.com>
	 <20050331165007.GA29674@pern.dea.icai.upco.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2005 18:50:07 +0200, Romano Giannetti <romanol@upco.es> wrote:
> On Thu, Mar 31, 2005 at 10:15:26AM -0500, Dmitry Torokhov wrote:
> > On Thu, 31 Mar 2005 16:47:29 +0200, Romano Giannetti <romanol@upco.es> wrote:
> > >
> > > The bad news is that with 2.6.12-rc1 (no preempt) swsusp fails to go.
> >
> > Ok, I see you have an ALPS touchpad. I think this patch will help you
> > with swsusp:
> >
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=111212532524998&q=raw
> 
> Yes! With this it works ok.
> 
> > Also, could you please try sticking psmouse_reset(psmouse) call at the
> > beginning of drivers/input/mouse/alps.c::alps_reconnect() and see if
> > it can suspend _without_ the patch above.
>

Both patches are working for me (Dell D600). before i was unable to
suspend to disk on this laptop (it was stuck in alps code).

By the way, i have an unrelated problem:
if the kernel was booted with the "noresume" option, it cannot be
suspended, it fails with:

swsusp: FATAL: cannot find swap device, try swapon -a!

Thanks,

Benoit
