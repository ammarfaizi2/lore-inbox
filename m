Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbWCHXfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWCHXfU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 18:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWCHXfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 18:35:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62127 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751501AbWCHXfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 18:35:17 -0500
Date: Wed, 8 Mar 2006 15:29:28 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: gregkh@suse.de, bunk@stusta.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz,
       pcihpd-discuss@lists.sourceforge.net,
       Neil Brown <neilb@cse.unsw.edu.au>, mmokrejs@ribosome.natur.cuni.cz,
       Dave Hansen <haveblue@us.ibm.com>, Nathan Scott <nathans@sgi.com>
Subject: Re: State of the Linux PCI and PCI Hotplug Subsystems for
 2.6.16-rc5
Message-Id: <20060308152928.21afef81.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603081502350.32577@g5.osdl.org>
References: <20060306223545.GA20885@kroah.com>
	<20060308222652.GR4006@stusta.de>
	<20060308225029.GA26117@suse.de>
	<Pine.LNX.4.64.0603081502350.32577@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Wed, 8 Mar 2006, Greg KH wrote:
> > 
> > None, as I am expecting 2.6.16 to be out any day now.
> 
> Sadly, until the FC5 problems re at least somewhat more understood, I 
> don't think that's going to happen.
> 
> Trying to chase down Andrew's "laptop from hell" has also delayed even 
> doing a -rc6, although that is imminent.
> 

Well..  That's a problem which only I can reproduce, and that only after
applying sched patches while performing strange acts upon small animals.
Plus I don't think we're close to fixing it.

More serious matters would be:

- The x86_64-goes-oom-due-to-bio-using-GFP_DMA bug.  I'll send the patch
  over today.

- The some-ati-timers-go-too-fast bug.  I'll sndn that patch today as
  well.

- Neil is sitting on a radi1 BIO leak fix which we need.

- It would be nice to get Martin MOKREJ
  <mmokrejs@ribosome.natur.cuni.cz>'s full 16GB recognised again.  Dave
  Hansen is working on that.

- http://bugzilla.kernel.org/show_bug.cgi?id=6180 seems to be a recent
  XFS regression.

- Matthew Grant <grantma@anathoth.gen.nz>'s "rt_sigsuspend() does not
  return EINTR on 2.6.16-rc2+" might be a new poll() bug, but that one's
  hard and I suspect we'll need the extra testers which 2.6.16 will give to
  be able to work out whether it's real and what the fix is.

- http://bugzilla.kernel.org/show_bug.cgi?id=6177 _looks_ like a serious
  TCP regression, but that happened between 2.6.14 and 2.6.15 and that's
  the only report I've seen.

Plus lots of other stuff, probably.
