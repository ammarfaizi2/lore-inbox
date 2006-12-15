Return-Path: <linux-kernel-owner+w=401wt.eu-S964945AbWLOVDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964945AbWLOVDc (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 16:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964953AbWLOVDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 16:03:32 -0500
Received: from alephnull.demon.nl ([83.160.184.112]:58332 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964945AbWLOVDb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 16:03:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=1148133259;
	d=wantstofly.org;
	h=date:from:to:cc:subject:message-id:mime-version:content-type:
	content-disposition:in-reply-to:user-agent;
	b=tZMSlFQHf0WWfm4T21Vbq7SLmrqgrw36R5syJBOL9rzR9y2wKY6HE1tpvfAvv
	/9G/MISR7pEfz9PXcCtmuo9pQ==
Date: Fri, 15 Dec 2006 22:03:29 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Martin Michlmayr <tbm@cyrius.com>, Riku Voipio <riku.voipio@iki.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: r8169 on n2100 (was Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions))
Message-ID: <20061215210329.GB14860@xi.wantstofly.org>
References: <20061107115940.GA23954@unjust.cyrius.com> <20061108203546.GA32247@kos.to> <20061109221338.GA17722@electric-eye.fr.zoreil.com> <20061109231408.GB6611@xi.wantstofly.org> <20061110185937.GA9665@electric-eye.fr.zoreil.com> <20061121102458.GA7846@deprecation.cyrius.com> <20061121204527.GA13549@electric-eye.fr.zoreil.com> <20061122231656.GA9991@electric-eye.fr.zoreil.com> <20061215132740.GD11579@xi.wantstofly.org> <20061215201522.GA11288@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061215201522.GA11288@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 15, 2006 at 09:15:22PM +0100, Francois Romieu wrote:

> > Is there a way we can have this done by default on the n2100?  I guess
> > that since it's a PCI device, there isn't much hope for that..?
> 
> Do you mean an automagically tuned default value based on CONFIG_ARM ?

No, that wouldn't make sense, that's like making a workaround depend on
arch == i386.

I'm thinking that we should somehow enable this option on the n2100
built-in r8169 ports by default only.  Since the n2100 also has a mini-PCI
slot, and it is in theory possible to put an r8169 on a mini-PCI card,
the workaround probably shouldn't apply to those, so testing for
CONFIG_MACH_N2100 also isn't the right thing to do.
