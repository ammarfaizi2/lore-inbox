Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266536AbUFVAsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266536AbUFVAsV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 20:48:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266539AbUFVAsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 20:48:21 -0400
Received: from palrel11.hp.com ([156.153.255.246]:4992 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S266536AbUFVAsT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 20:48:19 -0400
Date: Mon, 21 Jun 2004 17:48:13 -0700
To: Andrew Morton <akpm@osdl.org>
Cc: Joshua Kwan <jkwan@rackable.com>, linux-kernel@vger.kernel.org
Subject: Re: What happened to linux/802_11.h?
Message-ID: <20040622004813.GA12334@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <pan.2004.06.21.22.25.18.591967@triplehelix.org> <20040621173827.0403618b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040621173827.0403618b.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 05:38:27PM -0700, Andrew Morton wrote:
> Joshua Kwan <jkwan@rackable.com> wrote:
> >
> > Hello,
> > 
> > linus.patch from -mm1:
> > # BitKeeper/deleted/.del-802_11.h~9b6bd4cff8af7a90
> > #   2004/06/18 09:47:58-07:00 torvalds@ppc970.osdl.org +0 -0
> > #   Delete: include/linux/802_11.h
> > 
> > Why was this file removed?
> 
> Nothing in the kernel is using it.

	It was a remnant from the old aironet4500 driver that was
removed during 2.5.X. It was also confusing because there is a file
called drivers/net/wireless/ieee802_11.h that has a somewhat similar
purpose and is used in various drivers (Orinoco, Atmel). I think it
was discussed on netdev.
	I was not aware that IPW2100 was using it. I could not try
this driver because it doesn't compile with gcc 2.95.

> > The IPW2100 driver
> > (http://ipw2100.sourceforge.net) uses its definitions and now won't build
> > against -bk or -mm kernel source.
> 
> Jean, should we restore 802_11.h, or is there some alternative file which
> that driver should be using?

	Well, Jeff explicitely said that we should not care about
drivers outside the kernel ;-)
	Seriously, I see three solutions :
	1) Convert ipw2100 to using drivers/net/wireless/ieee802_11.h,
extend this header as necessary
	2) Have ipw2100 use a private version of 802_11.h
	3) Convince us that this file is really needed (good luck)
	Obviously (1) is better in the long term.

	Have fun...

	Jean
