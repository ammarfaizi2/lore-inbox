Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262532AbVCVDKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbVCVDKX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 22:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbVCVCom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:44:42 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:22449 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262328AbVCVCHy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 21:07:54 -0500
Date: Tue, 22 Mar 2005 03:07:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, len.brown@intel.com
Subject: Re: 2.6.12-rc1-mm1: Kernel BUG at pci:389
Message-ID: <20050322020738.GA1628@elf.ucw.cz>
References: <20050321025159.1cabd62e.akpm@osdl.org> <200503212343.31665.rjw@sisk.pl> <20050321160306.2f7221ec.akpm@osdl.org> <20050322004456.GB1372@elf.ucw.cz> <20050321170623.4eabc7f8.akpm@osdl.org> <20050322013535.GA1421@elf.ucw.cz> <20050321175232.34d93a13.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050321175232.34d93a13.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 21-03-05 17:52:32, Andrew Morton wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
> >
> > > Could I suggest that you prepare a fixup against 2.6.12-rc1-mm1 and send
> >  > that to Len and myself?  If that fixup is not suitable for a 2.6.12-rc1
> >  > based tree then I can look after it until things get flushed out.
> > 
> >  Could you just revert those two patches? First one is very
> >  wrong. Second one might be fixed, but... See comments below.
> 
> I could revert them locally, but that wouldn't gain us much.

You mean that Len has to revert them or revert is "ineffective"?

> Greg hasn't taken the pm_message_t patches yet.  Perhaps that's for the best.
> 
> Perhaps I should just jam everything-from-Pavel into Linus's tree as soon
> as he returns and then we can fix up the downstream fallout in the various
> bk trees?

Yes, that would help a lot. I was waiting with
"turn-pm_message_t-into-struct" until all pm_message_t patches reached
Linus so that there's not a mess "in flight". Len's patch pretty much
depends on pm_message_t already being converted... (and I'd prefer it
to wait a while, so we can see which problems were introduced by
conversion and which are due to ACPI BIOS bugs).

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
