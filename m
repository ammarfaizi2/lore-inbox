Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272056AbRIDSFk>; Tue, 4 Sep 2001 14:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272058AbRIDSF2>; Tue, 4 Sep 2001 14:05:28 -0400
Received: from [194.213.32.141] ([194.213.32.141]:1796 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S272052AbRIDSFV>;
	Tue, 4 Sep 2001 14:05:21 -0400
Date: Tue, 4 Sep 2001 16:58:37 +0000
From: Pavel Machek <pavel@suse.cz>
To: Alexander Viro <viro@math.psu.edu>
Cc: Bryan Henderson <hbryan@us.ibm.com>, linux-fsdevel@vger.kernel.org,
        linux-fsdevel-owner@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean-Marc Saffroy <saffroy@ri.silicomp.fr>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFD] readonly/read-write semantics
Message-ID: <20010904165836.A48@toy.ucw.cz>
In-Reply-To: <OF8E62B3C8.CD1E8E23-ON87256AB9.007E8B1A@boulder.ibm.com> <Pine.GSO.4.21.0109010015380.15931-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.4.21.0109010015380.15931-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Sep 01, 2001 at 12:23:05AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > 2) I'd like to see a readonly mount state defined as "the filesystem will
> > not change.  Period."  Not for system calls in progress, not for cache
> > synchronization, not to set an "unmounted" flag, not for writes that are
> > queued in the device driver or device.  (That last one may stretch
> > feasability, but it's a worthy goal anyway).
> 
> It doesn't work.  Think of r/o mounting of remote filesystem.  Do you
> suggest that it should make it impossible to change from other clients?

Okay, make the definition

"this kernel will not attempt to change anything on that filesystem".

This does not neccesarily mean -oro should have this semantics, maybe we
need something like -orealro, but we should have some mode when writing on
that disk is taboo. [I need that for suspend-to-disk support: I need to 
write suspend data do disk, while I need noone to touch those disks,
because I already took snapshot.]
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

