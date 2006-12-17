Return-Path: <linux-kernel-owner+w=401wt.eu-S1751942AbWLQVNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942AbWLQVNS (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 16:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751943AbWLQVNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 16:13:18 -0500
Received: from alephnull.demon.nl ([83.160.184.112]:32950 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbWLQVNR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 16:13:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=1148133259;
	d=wantstofly.org;
	h=date:from:to:cc:subject:message-id:mime-version:content-type:
	content-disposition:in-reply-to:user-agent;
	b=gm0clU1h8BDy42KxmWBtzS7cgniVNktaUEkH9HhTovbn18jNsWyZjinfEgKCc
	fVSoNslxIKqoJGxj0++VVXibw==
Date: Sun, 17 Dec 2006 22:13:13 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: Martin Michlmayr <tbm@cyrius.com>, linux-kernel@vger.kernel.org,
       romieu@fr.zoreil.com, rmk@arm.linux.org.uk, dan.j.williams@intel.com
Subject: Re: r8169 on n2100 (was Re: r8169 mac address change (was Re: [0/3] 2.6.19-rc2: known regressions))
Message-ID: <20061217211313.GG23747@xi.wantstofly.org>
References: <20061215201522.GA11288@electric-eye.fr.zoreil.com> <20061215210329.GB14860@xi.wantstofly.org> <20061215211435.GB10367@flint.arm.linux.org.uk> <20061216230901.GA23143@xi.wantstofly.org> <20061216233134.GA25177@electric-eye.fr.zoreil.com> <20061216235245.GA23238@xi.wantstofly.org> <20061217192812.GD17535@deprecation.cyrius.com> <20061217195635.GA10181@kos.to> <20061217195728.GF23747@xi.wantstofly.org> <20061217210209.GA13632@kos.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061217210209.GA13632@kos.to>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 17, 2006 at 11:02:10PM +0200, Riku Voipio wrote:

> > > bah. 2.6.20-git shows nothing (with or without Lennert's patch) after
> > > the following:
>  
> > > Uncompressing Linux..........................................................................................done, booting the kernel.
> > 
> > Try the printascii()-in-printk() hack in my svn tree.
> 
> Thanks, that was priceless advice. I reverted 
> da2c12a279ae225f3d4696f76cb3b32a5bec5bfb "[ARM] Clean up ioremap code"
> and n2100 booted fine.

Can you try with da2c12a279ae225f3d4696f76cb3b32a5bec5bfb with the
following patch applied?

	http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=4030/1


> I can now confirm Lennerts patch makes r8169 work without any module
> parameter work on Thecus n2100.

Yay.  Aunt Tillie will be so happy.

Francois, if you submit the r8169.c half of that patch, I'll do my half.
