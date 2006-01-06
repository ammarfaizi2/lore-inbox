Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752505AbWAFS7Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbWAFS7Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:59:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbWAFS7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:59:15 -0500
Received: from colin.muc.de ([193.149.48.1]:17426 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1752466AbWAFS7M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:59:12 -0500
Date: 6 Jan 2006 19:59:04 +0100
Date: Fri, 6 Jan 2006 19:59:04 +0100
From: Andi Kleen <ak@muc.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Yinghai Lu <yinghai.lu@amd.com>,
       vgoyal@in.ibm.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, discuss@x86-64.org,
       linuxbios@openbios.org
Subject: Re: Inclusion of x86_64 memorize ioapic at bootup patch
Message-ID: <20060106185904.GC39582@muc.de>
References: <20060103044632.GA4969@in.ibm.com> <86802c440601051630i4d52aa2fj1a2990acf858cd63@mail.gmail.com> <20060105163848.3275a220.akpm@osdl.org> <m164ox6ayf.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m164ox6ayf.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 01:02:16AM -0700, Eric W. Biederman wrote:
> Andrew Morton <akpm@osdl.org> writes:
> >
> > Please don't top-post.
> >
> >> 
> >> On 1/2/06, Vivek Goyal <vgoyal@in.ibm.com> wrote:
> >> > Hi Andi,
> >> >
> >> > Can you please include the following patch. This patch has already been
> > pushed
> >> > by Andrew.
> >> >
> >> >
> > http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm3/broken-out/x86_64-io_apicc-memorize-at-bootup-where-the-i8259-is.patch
> >
> > IIRC, I dropped this patch because of discouraging noises from Andi and
> > because underlying x86_64 changes broke it in ugly ways.
> 
> Ok.  I just as extensively as I could and I can't find the under laying
> x86_64 changes that Andi mentioned he was working on.  I have looked
> in current -mm and in Andi merge and experimental quilt trees.  It
> could be that I'm  blind but I looked and I did not see them.
> 
> Even in the discussion where this was mentioned there never was a 
> semantic conflict.  But rather two patches passing so close they
> touched the same or neighboring lines of code.
> 
> > It needs to be
> > redone and Andi's objections (whatever they were) need to be addressed or
> > argued about.
> 
> The difference was one of approach.  Andi wanted us to treat the apics
> as black boxes and save and restore register values with no regard as
> to what the registers did.  This is theoretically more future proof,
> but it looses flexibility.

Well I still think it would be better to do it in the generic way,
but i'm not feeling very strongly about it anymore.

> to change the destination cpu, in the kexec on panic case.  This
> is something that cannot be done if we simply saved off the registers.
>      
> > Right now the patch is rather dead.
> 
> Current the referred to patch applies just fine, to 2.6.15,
> and except for a conflict with the above mentioned patch which
> applies fine to 2.6.15-mm1 as well.


It conflicts with the x86-64 timer routing rewrite I did, but that's currently
on hold because it has some other issues.  I can merge them later, no problem.

-Andi
