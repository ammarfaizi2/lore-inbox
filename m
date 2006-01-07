Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161023AbWAGTmM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161023AbWAGTmM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 14:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161024AbWAGTmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 14:42:12 -0500
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:59049 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S1161023AbWAGTmL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 14:42:11 -0500
Date: Sat, 07 Jan 2006 20:42:07 +0100
From: Jan Spitalnik <lkml@spitalnik.net>
Subject: Re: [PATCH] Disable swsusp on CONFIG_HIGHMEM64
In-reply-to: <20060106043019.GA2545@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Message-id: <200601072042.07337.lkml@spitalnik.net>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Content-disposition: inline
User-Agent: KMail/1.9
References: <200601061945.09466.lkml@spitalnik.net>
 <200601071604.03846.lkml@spitalnik.net> <20060106043019.GA2545@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dne pátek 06 leden 2006 05:30 Pavel Machek napsal(a):
> On Sat 07-01-06 16:04:03, Jan Spitalnik wrote:
> > Dne pátek 06 leden 2006 00:43 Pavel Machek napsal(a):
> > > On Fri 06-01-06 19:45:09, Jan Spitalnik wrote:
> > > > Hello,
> > > >
> > > > suspending to disk is not supported on CONFIG_HIGHMEM64G setups
> > > > (http://suspend2.net/features). Also suspend to ram doesn't work.
> > > > This patch
> > >
> > > NAK. suspend2.net describes very different code.
> >
> > Well, I was using suspend2.net's page just as reference, to point out the
> > fact that HIGHMEM is on both suspend "platforms" supported only up to 4G.
> > I was not refering to suspend2's actual features, but rather swsusp's (or
> > what's the proper name for suspend1 code). So i guess the patch still
> > holds, no?
>
> No.

Could you be please more specific? Is there some list of swsusp's features? 
swsusp.txt says that it "A: It should work okay with highmem." Does that mean 
both possible highmem configurations?

>
> > > > fixes Kconfig to disallow such combination. I'm not 100% sure about
> > > > the ACPI_SLEEP part, as it might be disabling some working setup -
> > > > but i think that s2r and s2d are the only acpi sleeps allowed, no?
> > >
> > > s2ram probably works. Try getting it working without highmem64,
> > > then turn it on.
> >
> > It works with HIGHMEM but not HIGHMEM64G. You can find the oops from
> > HIGHMEM64G below. It crashes very reliably on little stress after resume.
>
> s2ram should not depend on ammount of memory. Try debugging
> it, but do not disable feature just because it does not work
> for you. I'd start with minimum drivers...

Well, I've tried it with the bare minimum that was needed to run the system, 
but it did the same. I'm sorry but i lack the knowledge to properly debug it 
on source level.  Do you see something that perhaps i don't see in the oops? 
Maybe some clues as what might be going wrong?

Thanks,

-- 
Jan Spitalnik
jan@spitalnik.net
