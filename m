Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbTHZQQb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 12:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbTHZQQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 12:16:31 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:61707 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S261380AbTHZQQ3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 12:16:29 -0400
Date: Tue, 26 Aug 2003 18:11:49 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Rene Rebe <rene.rebe@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.22 released
Message-ID: <20030826161149.GA25064@alpha.home.local>
References: <200308251148.h7PBmU8B027700@hera.kernel.org> <20030825132358.GC14108@merlin.emma.line.org> <20030826.151903.640928788.rene.rebe@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030826.151903.640928788.rene.rebe@gmx.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 03:19:03PM +0200, Rene Rebe wrote:
> Hi,
> 
> On: Mon, 25 Aug 2003 15:23:58 +0200,
>     Matthias Andree <matthias.andree@gmx.de> wrote:
> > On Mon, 25 Aug 2003, Marcelo Tosatti wrote:
> > 
> > > - 2.4.22-rc4 was released as 2.4.22 with no changes.
> 
> I would like to vote for i2c-2.8.0 ...

Well, there are two types of patches/add-ons out there :
  - those which always apply very well and very easily : ALSA, i2c, ...
  - those which are very sensible to frequent core changes : VM, FS, ...

ACPI and IDE were of the later type, and were included lately, one at a time.
This greatly eased the production of "alternative" kernels, because most others
were really easy to add.

Considering that Marcelo will never apply everything at once, would you find
more interesting that he merges difficult parts once, and let the easy ones to
all of us, or that he merges only the easy parts and let us have a hard time
merging the rest every time a new pre-release goes out ?

If I had the choice, I'd rather merge ALSA, i2c and friends myself, and rely on
a correctly merged VM or XFS or whatever. When you compile ALSA or i2c for your
kernel, you don't even notice that they touch the kernel, so what's the
problem ? We're not *that* lazy !

As a final note, I would say that this even increases test coverage : let's
assume that 1% of us replace the VM, while 20% add i2c. Then including i2c
will lead to 100% of us testing it and 1% of us testing the VM. On the other
hand, merging the VM into mainline whill lead to 100% of us testing it and 20%
of us testing i2c. Which case do you think is more reasonable for stability ?

Regards,
Willy

