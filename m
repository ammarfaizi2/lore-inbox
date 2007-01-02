Return-Path: <linux-kernel-owner+w=401wt.eu-S1754973AbXABWKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754973AbXABWKO (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 17:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754982AbXABWKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 17:10:13 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:33062
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754979AbXABWKL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 17:10:11 -0500
Date: Tue, 02 Jan 2007 14:10:10 -0800 (PST)
Message-Id: <20070102.141010.78710062.davem@davemloft.net>
To: segher@kernel.crashing.org
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org, devel@laptop.org,
       dmk@flex.com, wmb@firmworks.com, jg@laptop.org
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
From: David Miller <davem@davemloft.net>
In-Reply-To: <578a242271c65db1cf8d85e943fab67a@kernel.crashing.org>
References: <bb0d56f649449edb8b5cc0e1c12ede29@kernel.crashing.org>
	<1167773556.6165.79.camel@localhost.localdomain>
	<578a242271c65db1cf8d85e943fab67a@kernel.crashing.org>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Tue, 2 Jan 2007 22:40:17 +0100

> >> The kernel doesn't care if one CPU is in OF land while the others
> >> are doing other stuff -- well you have to make sure the OF won't
> >> try to use a hardware device at the same time as the kernel, true.
> >
> > That statement alone hides an absolute can of worms btw ;-)
> 
> Oh I know.  With a sane OF implementation, things will work
> out fine though.

Note that on PPC they do not co-exist with the OFW after
the kernel boots up because it's an enormous can of worms
if not downright impossible.

If I didn't need to make certain OFW calls after bootup on
sparc I'd throw away the OFW mappings and image too.

With software replaced TLBs it's an enormous hassle to
coexist safely with the OFW image.  The locking is a
second order issue.
