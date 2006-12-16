Return-Path: <linux-kernel-owner+w=401wt.eu-S1030576AbWLPCJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030576AbWLPCJQ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 21:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030577AbWLPCJP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 21:09:15 -0500
Received: from alephnull.demon.nl ([83.160.184.112]:58660 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030576AbWLPCJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 21:09:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=1148133259;
	d=wantstofly.org;
	h=date:from:to:cc:subject:message-id:mime-version:content-type:
	content-disposition:in-reply-to:user-agent;
	b=B2e5sS4UcZ7hu6hKyQrg0loiSNoKxgQRz7meqgO03q10mvCQvJBDvLpu42TbR
	ZzsZB3WLstsO8ifyqC93xWPmg==
Date: Sat, 16 Dec 2006 03:09:10 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Martin Michlmayr <tbm@cyrius.com>, Riku Voipio <riku.voipio@iki.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: r8169 on n2100 (was Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions))
Message-ID: <20061216020910.GB15310@xi.wantstofly.org>
References: <20061109221338.GA17722@electric-eye.fr.zoreil.com> <20061109231408.GB6611@xi.wantstofly.org> <20061110185937.GA9665@electric-eye.fr.zoreil.com> <20061121102458.GA7846@deprecation.cyrius.com> <20061121204527.GA13549@electric-eye.fr.zoreil.com> <20061122231656.GA9991@electric-eye.fr.zoreil.com> <20061215132740.GD11579@xi.wantstofly.org> <20061215201522.GA11288@electric-eye.fr.zoreil.com> <20061215210329.GB14860@xi.wantstofly.org> <20061216005439.GB11288@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061216005439.GB11288@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2006 at 01:54:39AM +0100, Francois Romieu wrote:

> > No, that wouldn't make sense, that's like making a workaround depend on
> > arch == i386.
> > 
> > I'm thinking that we should somehow enable this option on the n2100
> > built-in r8169 ports by default only.  Since the n2100 also has a mini-PCI
> > slot, and it is in theory possible to put an r8169 on a mini-PCI card,
> > the workaround probably shouldn't apply to those, so testing for
> > CONFIG_MACH_N2100 also isn't the right thing to do.
> 
> Ok, I thought it was a useability thing.

It is.


> Let aside a few configurations, the sensible default value for this
> option is not clear. I have no objection against a patch but it seems
> a bit academic as long as nobody complains (you can call me lazy too).

I'm thinking that the entire option is just wrong.  It sucks for
distributors to have to make the choice between having it always on
and having it always off.  It sucks for end users compiling their
own kernels, because their ethernet won't work out of the box, and
they will have no idea what's wrong and what to do.
