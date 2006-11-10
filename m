Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161363AbWKJRZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161363AbWKJRZv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 12:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161352AbWKJRZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 12:25:51 -0500
Received: from wr-out-0506.google.com ([64.233.184.228]:43191 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161363AbWKJRZu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 12:25:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lbISZw6cMUwO7uHaALhrU0U+d7DPB8V2qHRM2c6gsCysymdUN8+/6E3j+72nAiDG6tfdboggmxpmdywDz8OmIcgpzGa6dqX23u2kbYXd4AeoUhNQlHoSsuq2zmkro2l5G/9+yV3k/t83jQhdjHY1617L76F414Zw8VrNpqAZV8s=
Message-ID: <40f323d00611100925l45b2415bjcc611df6e4d1f7d4@mail.gmail.com>
Date: Fri, 10 Nov 2006 18:25:26 +0100
From: "Benoit Boissinot" <bboissin@gmail.com>
To: tglx@linutronix.de
Subject: Re: 2.6.19-rc5-mm1
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1163177952.8335.221.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061108015452.a2bb40d2.akpm@osdl.org>
	 <40f323d00611100829m5fbd32cdt14c307e492df2984@mail.gmail.com>
	 <1163177952.8335.221.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/06, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Fri, 2006-11-10 at 17:29 +0100, Benoit Boissinot wrote:
> > On 11/8/06, Andrew Morton <akpm@osdl.org> wrote:
> > > [snip]
> > > - The hrtimer+dynticks code still doesn't work right for machines which halt
> > >   their TSC in low-power states.
> > >
> >
> > With CONFIG_NO_HZ=y, xmoto (xmoto.sf.net, a 3d game) is sluggish, the
> > movement is not fluid (it is "bursty").
> >
> > .config is at http://perso.ens-lyon.fr/benoit.boissinot/kernel/config-2.6.19-rc5-mm1
> > lspci -vv: http://perso.ens-lyon.fr/benoit.boissinot/kernel/docked_lspci
> > dmesg: http://perso.ens-lyon.fr/benoit.boissinot/kernel/dmesg-2.6.19-rc5-mm1
>
> I'm confused about that one:
>
> [    8.966364] Disabling NO_HZ and high resolution timers due to timer broadcasting (C3 stops local apic)
>
> This message is nowhere in rc5-mm1. It was in rc4-mmX, but got removed
> in the updates.
>
I forget to mention I reverted the following patches from -mm:
i386-apic-timer-use-clockevents-broadcast.patch
acpi-verify-lapic-timer.patch
acpi-verify-lapic-timer-exports.patch
acpi-verify-lapic-timer-fix.patch

since it did not boot with them.

> > I can test any patch or provide any needed information.
>
> http://tglx.de/private/tglx/2.6.19-rc5-mm1-dyntick.diff
>
> That's the rework I did yesterday.
>

I'll undo the reverts I did and try it on top of -mm

Thanks,

Benoit
