Return-Path: <linux-kernel-owner+w=401wt.eu-S932684AbWLTAKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbWLTAKN (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 19:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932735AbWLTAKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 19:10:13 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:46932 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932700AbWLTAKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 19:10:11 -0500
Date: Wed, 20 Dec 2006 00:09:55 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: David Brownell <david-b@pacbell.net>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
Message-ID: <20061220000955.GA17231@srcf.ucam.org>
References: <20061219185223.GA13256@srcf.ucam.org> <200612191322.13378.david-b@pacbell.net> <20061219225729.GA15777@srcf.ucam.org> <200612191536.28998.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612191536.28998.david-b@pacbell.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
Subject: Re: Changes to PM layer break userspace
X-SA-Exim-Version: 4.2.1 (built Tue, 20 Jun 2006 01:35:45 +0000)
X-SA-Exim-Scanned: Yes (on vavatch.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 03:36:28PM -0800, David Brownell wrote:
> On Tuesday 19 December 2006 2:57 pm, Matthew Garrett wrote:
> > The fact that something is scheduled to be removed in July 2007 does 
> > *not* mean it's acceptable to break it in 2006. We need to find a way to 
> > fix this functionality in the meantime.
> 
> The disconnect here is analagous to:  I tell you the alleged perpetual
> motion machine never worked, and can't ever work; and you push back and
> say that you need a perpetual motion machine that works, NOW please,
> because you need something that pushes those widgets around.  (There are
> better ways to push widgets than side effects of a broken machine...)

But it *did* work. Userspace could ask the device to suspend, and (in 
general) that would result in the device going into a lower power state. 
You've broken that without providing an alternative.

> Given that your examples are network adapters, you should really look
> more at why "ifdown eth0" (etc) having drivers put the device into a
> low power state (like PCI D3hot, or maybe D2) wouldn't work in any
> particular case.  If you actually have such cases, then maybe those
> specific drivers need to drive new power management interfaces.

We seem to be arguing at cross purposes here. I've absolutely no 
objection to this approach in the long run, just as I've got no 
objection to flying cars or food pills or moon pods. When these things 
exist, the world will indeed be a glorious place. But that doesn't 
justify me slashing your tyres, poisoning your crops or setting fire to 
whatever the real-world analogue of a moon pod is. I had something that 
worked. Now I don't, but instead have the promise that at some point 
I'll have something better. Understand why I'm a touch irritated?

> That's a workable approach to resolving the underlying problem in the
> long term.  In the short term, notice the system still works correctly
> if you don't try writing those files.

Well, except I'm now burning an extra couple of watts of power. I 
consider that pretty broken.

> I'd not be keen on reverting Linus' patch [1] myself, even though few
> drivers have started to use that mechanism yet; that would be a step
> backwards, and would perpetuate users of that broken sysfs file.

I'm sorry, which bit of "Don't break userspace API without adequate 
prior warning and with a workable replacement" is difficult to 
understand?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
