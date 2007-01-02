Return-Path: <linux-kernel-owner+w=401wt.eu-S932767AbXABK6K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932767AbXABK6K (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 05:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932821AbXABK6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 05:58:10 -0500
Received: from smtp6.orange.fr ([193.252.22.25]:43918 "EHLO smtp6.orange.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932767AbXABK6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 05:58:09 -0500
X-ME-UUID: 20070102105807344.541631C00086@mwinf0602.orange.fr
Subject: Re: 2.6.19-rc5: grub is much slower resuming from suspend-to-disk
	than in 2.6.18
From: Xavier Bestel <xavier.bestel@free.fr>
To: Stefan Seyfried <seife@suse.de>
Cc: Lee Garrett <lee-in-berlin@web.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20070102100513.GA8693@suse.de>
References: <200611121436.46436.arvidjaar@mail.ru> <45844374.60903@web.de>
	 <20070102100513.GA8693@suse.de>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 11:58:03 +0100
Message-Id: <1167735483.19781.90.camel@frg-rhel40-em64t-03>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2007-01-02 at 11:05 +0100, Stefan Seyfried wrote:
> On Sat, Dec 16, 2006 at 08:05:24PM +0100, Lee Garrett wrote:
> > Andrey Borzenkov wrote:
> > > [...]
> > >This is rather funny; in 2.6.19-rc5 grub is *really* slow loading kernel when I switch on the 
> > >system after suspend to disk. Actually, after kernel has been loaded, the whole resuming (up to 
> > >the point I have usable desktop again) takes about three time less than the process of loading 
> > >kernel + initrd. During loading disk LED is constantly lit. This almost looks like kernel leaves 
> > >HDD in some strange state, although I always assumed HDD/IDE is completely reinitialized in this 
> > >case.
> > > [...]
> > 
> > I had the same problem (/boot on reiserfs, grub hanging for ages after resume
> > with 2.6.19), but in 2.6.19.1 it seems fixed. Do you still have this bug,
> > Andrey? I didn't find an update on this issue on LKML.
> 
> I'm pretty sure this is just a coincidence, an issue about how the kernel
> image is actually layed out on your filesystem. I don't think it actually
> has to do anything with the version.

Isn't the cause just that with that kernel the fs image is left unclean,
and grub has to replay the journal, which is slow ? 

	Xav

