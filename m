Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTEFMHc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 08:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbTEFMHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 08:07:32 -0400
Received: from mail.zmailer.org ([62.240.94.4]:6857 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S262610AbTEFMHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 08:07:25 -0400
Date: Tue, 6 May 2003 15:19:54 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Simon Kelley <simon@thekelleys.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Binary firmware in the kernel - licensing issues.
Message-ID: <20030506121954.GO24892@mea-ext.zmailer.org>
References: <3EB79ECE.4010709@thekelleys.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EB79ECE.4010709@thekelleys.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 12:38:54PM +0100, Simon Kelley wrote:
> I'm working from source drivers released by Atmel themselves last
> year under the GPL so there are no problems with the code - each
> source file from Atmel has a GPL notice at the top.
.....
> It isn't clear what the license agreement referred to in the above
> actually is, but I don't think it's reasonable to just assume it's the
> GPL and shove these files into the kernel as-is.
> 
> I shall contact Atmel for advice and clarification but my question for
> the list is, what should I ask them to do? It's unlikely that they will
> release the source to the firmware and even if they did I wouldn't want
> firmware source  in the kernel tree since the kernel-build toolchain
> won't be enough to build the firmware. What permissions do they have to
> give to make including this stuff legal and compatible with the rest of
> the kernel?

Adding a phrase like:  "This firmware binary block is intended to be
used in BSD/GPL licensed driver"   would definitely clarify it.
Possibly adding:
  "Source code/further explanations for this binary block
   are available at file FFFF.F / are not available."

Being able to understand some binary blob would be nice, but being
able to modify and compile it isn't necessary, IMO.  Most important,
of course, is to be able to use the thing.  CPU type independently
most preferrably.

> Given the current SCO-IBM situation I don't want to be responsible
> for introducing any legally questionable IP into the kernel tree.
> 
> This situation must have come up before, how was it solved then?

There are drivers with binary-only firmwares, and drivers with
firmware sources.

E.g.:  drivers/scsi/qlogic*_asm.c    vs.   drivers/scsi/aic7xxx/

People can quite freely produce drivers which have magic binary blobs
in them.     Also   drivers/net/e100/e100_ucode.h  contains such.

What Linux coders frown upon is having host CPU executed code in
obfuscated binary blobs (a'la NVIDIA case),  but as more and more
peripherals have processors themselves, and need microcode downloads,
at least I can accept there being binary blobs, if the host code
is all in pure source format.

Sometimes explaining some "why I poke XYZ into ABC register" isn't
all that important, as long as it is well compartementalized, and
things around it in general kernal can be altered to suite new
style of doing some deep things.

> Cheers,
> Simon.

/Matti Aarnio
