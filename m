Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWBDWYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWBDWYg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 17:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbWBDWYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 17:24:35 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:10257 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S964842AbWBDWYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 17:24:35 -0500
Date: Sat, 4 Feb 2006 23:24:29 +0100
From: Willy Tarreau <willy@w.ods.org>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Mathias Kretschmer <posting@blx4.net>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Linux Kernel Useful Patches (2.4)
Message-ID: <20060204222429.GA27562@w.ods.org>
References: <20060130085233.GA1498@w.ods.org> <43E27895.4010904@blx4.net> <20060204181554.GG6026@w.ods.org> <986ed62e0602041254h5ffd3e4eqb11e515ddf939fc6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <986ed62e0602041254h5ffd3e4eqb11e515ddf939fc6@mail.gmail.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Barry,

On Sat, Feb 04, 2006 at 12:54:15PM -0800, Barry K. Nathan wrote:
> On 2/4/06, Willy TARREAU <willy@w.ods.org> wrote:
> > The last O(1) patch I've seen does not apply to kernels more recent than 2.4.19
> > (it's on Ingo's site). Do you have any up to date pointer that I could use ?
> > However, I have a local rediff of the lowlat patch that I will include.
> 
> (This e-mail ended up being a bit longer than I intended. The most
> relevant stuff may be in the last couple of paragraphs, but I've
> included the whole message for the sake of completeness.)
> 
> Red Hat ships it in a 2.4.21-based kernel. Here's their latest source RPM:
> ftp://ftp.redhat.com/pub/redhat/linux/updates/enterprise/3AS/en/os/SRPMS/kernel-2.4.21-37.0.1.EL.src.rpm
> 
> However, I just remembered that the RHEL 3 kernel patch series starts
> with an -ac patch and builds up from there. I think it gets the O(1)
> scheduler from there but it might apply further patches to it (but I'm
> not 100% sure my memory is correct here).
> 
> Here's the last -ac patch:
> http://kernel.org/pub/linux/kernel/people/alan/linux-2.4/2.4.22/patch-2.4.22-ac4.bz2

That's what I found too, but -ac is too much different. I tried applying
some patches designed for 2.4.21-ac and 2.4.22-ac on their non-ac respective
equivalents, and they rejected a lot of stuff.

> If you want to see what Red Hat/Fedora did against 2.4.22, this is
> what the final Fedora Core 1 kernel shipped:
> http://cvs.fedora.redhat.com/viewcvs/rpms/kernel/FC-1/
> (There are newer kernels for FC1 from Fedora Legacy, but I think those
> just add security fixes.)
> 
> There's also 2.4.27-pre2-pac1, which has the O(1) scheduler. I don't
> know if it introduces any bugs into the O(1) scheduler though. (It did
> introduce a bug into the overcommit accounting, because part of it was
> missing.)
> http://kernel.org/pub/linux/kernel/people/bero/2.4/2.4.27/patch-2.4.27-pre2-pac1.bz2
> 
> Finally, 2.4.31-lck1 has the O(1) scheduler. This is the "base" patch
> for 2.4.31-lck1, which has O(1) but also has "kernel preemption, low
> latency and CK interactivity":
> http://www.plumlocosoft.com/kernel/patches/2.4/2.4.31/2.4.31-lck1/components/010-lckbase.diff.bz2
> 
> It's probably the most recent forward-port of the O(1) patch, and it's
> probably going to be the smallest diff to look through as well, if you
> want to cherry-pick it out and make it work on 2.4.32 or 2.4.33-pre.

I have not time to spend digging through the diff, but I can link to
it. It clearly is the most recent version amongst all those we have
seen.

> (I don't think I'll be doing this, however. The boxes I manage that
> would greatly benefit from O(1) will probably move to kernel 2.6 soon
> for other reasons anyway.)
> --
> -Barry K. Nathan <barryn@pobox.com>

Thanks for your investigation,
Willy

