Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965259AbWJCFmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965259AbWJCFmo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 01:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965258AbWJCFmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 01:42:44 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2055 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965259AbWJCFmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 01:42:43 -0400
Date: Tue, 3 Oct 2006 07:42:42 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18-1.2689.fc6PAE: oops in ext3_clear_inode+0x52/0x8b
Message-ID: <20061003054242.GK3278@stusta.de>
References: <451C33B2.5000007@goop.org> <20060928142313.8848cec9.akpm@osdl.org> <4521F5DE.7070302@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4521F5DE.7070302@sandeen.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 12:32:14AM -0500, Eric Sandeen wrote:
> Andrew Morton wrote:
> >On Thu, 28 Sep 2006 13:42:26 -0700
> >Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> >
> >>I just filed this in the Redhat bugzilla, since its from the FC6 distro 
> >>kernel.  But since its fairly close to current kernel.org kernels, I 
> >>thought it might be relevent.
> >>
> >>The bug is https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=208488
> >>
> >>Unfortunately this isn't a very useful report since it was a once-off, 
> >>and there's a P-tainting module in there.  But if anyone sees anything 
> >>else like this, it's interesting.
> >>
> >>The oops is:
> >>
> >>BUG: unable to handle kernel paging request at virtual address 756e6547
> >
> >756e6547 -> uneG.   Matches "GenuineIntel".
> >
> >That'll get written into a temporary page by the /proc/cpuinfo handler, so
> >it might just be a use-uninitialised.
> 
> But strangely enough, it's the second report we've seen with this exact 
> backtrace, and the same "Genu" ascii string where the i_default_acl should 
> be.
> 
> Both boxes had been through a suspend-to-ram recently, just in case that 
> might matter.
> 
> Seems like something more than random chance...

Can you give a pointer to the other report?

> -Eric

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

