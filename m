Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbTFILNH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 07:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbTFILNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 07:13:07 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:39177 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S262918AbTFILNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 07:13:06 -0400
Date: Mon, 9 Jun 2003 15:26:16 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org, David Mosberger <davidm@hpl.hp.com>
Subject: Re: [PATCH] [3/3] PCI segment support
Message-ID: <20030609152616.D15283@jurassic.park.msu.ru>
References: <20030407234411.GT23430@parcelfarce.linux.theplanet.co.uk> <20030408203824.A27019@jurassic.park.msu.ru> <20030608164351.GI28581@parcelfarce.linux.theplanet.co.uk> <20030609140749.A15138@jurassic.park.msu.ru> <20030609111739.GP28581@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030609111739.GP28581@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Mon, Jun 09, 2003 at 12:17:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 09, 2003 at 12:17:39PM +0100, Matthew Wilcox wrote:
> hmm, yes, well.  There's a certain amount of sloppiness allowed with
> it being a macro, in that bus->sysdata and dev->sysdata have the same
> value so it works both ways.

Well, it's true for many architectures, but not for all.
IIRC, bus->sysdata != dev->sysdata on sparc and parisc.

> Of course, this prohibits any architecture
> from implementing it as a function, so we really should make up our minds
> which it is to be.  It sounds like bus is more generally useful than dev,
> so I'll make that explicit.

Great.

Ivan.
