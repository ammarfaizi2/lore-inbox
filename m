Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262546AbVCVC5B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbVCVC5B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:57:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262549AbVCVCqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:46:00 -0500
Received: from fire.osdl.org ([65.172.181.4]:1955 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262373AbVCVC2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 21:28:11 -0500
Date: Mon, 21 Mar 2005 18:27:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, len.brown@intel.com,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.12-rc1-mm1: Kernel BUG at pci:389
Message-Id: <20050321182733.6a7e10f0.akpm@osdl.org>
In-Reply-To: <20050322020738.GA1628@elf.ucw.cz>
References: <20050321025159.1cabd62e.akpm@osdl.org>
	<200503212343.31665.rjw@sisk.pl>
	<20050321160306.2f7221ec.akpm@osdl.org>
	<20050322004456.GB1372@elf.ucw.cz>
	<20050321170623.4eabc7f8.akpm@osdl.org>
	<20050322013535.GA1421@elf.ucw.cz>
	<20050321175232.34d93a13.akpm@osdl.org>
	<20050322020738.GA1628@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> wrote:
>
> On Po 21-03-05 17:52:32, Andrew Morton wrote:
> > Pavel Machek <pavel@ucw.cz> wrote:
> > >
> > > > Could I suggest that you prepare a fixup against 2.6.12-rc1-mm1 and send
> > >  > that to Len and myself?  If that fixup is not suitable for a 2.6.12-rc1
> > >  > based tree then I can look after it until things get flushed out.
> > > 
> > >  Could you just revert those two patches? First one is very
> > >  wrong. Second one might be fixed, but... See comments below.
> > 
> > I could revert them locally, but that wouldn't gain us much.
> 
> You mean that Len has to revert them or revert is "ineffective"?

The patches are in Len's tree.

> > Greg hasn't taken the pm_message_t patches yet.  Perhaps that's for the best.
> > 
> > Perhaps I should just jam everything-from-Pavel into Linus's tree as soon
> > as he returns and then we can fix up the downstream fallout in the various
> > bk trees?
> 
> Yes, that would help a lot. I was waiting with
> "turn-pm_message_t-into-struct" until all pm_message_t patches reached
> Linus so that there's not a mess "in flight". Len's patch pretty much
> depends on pm_message_t already being converted... (and I'd prefer it
> to wait a while, so we can see which problems were introduced by
> conversion and which are due to ACPI BIOS bugs).

OK, well unless someone has objections I'll just send all these

swsusp-add-missing-refrigerator-calls.patch
suspend-to-ram-update-videotxt-with-more-systems.patch
pm-remove-obsolete-pm_-from-vtc.patch
swsusp-small-updates.patch
swsusp-1-1-kill-swsusp_restore.patch
fix-pm_message_t-in-generic-code.patch
fix-u32-vs-pm_message_t-in-usb.patch
more-pm_message_t-fixes.patch
fix-u32-vs-pm_message_t-confusion-in-oss.patch
fix-u32-vs-pm_message_t-confusion-in-pcmcia.patch
fix-u32-vs-pm_message_t-confusion-in-framebuffers.patch
fix-u32-vs-pm_message_t-confusion-in-mmc.patch
fix-u32-vs-pm_message_t-confusion-in-serials.patch
fix-u32-vs-pm_message_t-in-macintosh.patch
fix-u32-vs-pm_message_t-confusion-in-agp.patch

to Linus when he reappears and then I'll duck for cover and let you guys
sort it out ;)

