Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270779AbRIAOmk>; Sat, 1 Sep 2001 10:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270774AbRIAOmb>; Sat, 1 Sep 2001 10:42:31 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:22484 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S270758AbRIAOmX>; Sat, 1 Sep 2001 10:42:23 -0400
Date: Sat, 1 Sep 2001 16:42:38 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Bryan Henderson <hbryan@us.ibm.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFD] readonly/read-write semantics
Message-ID: <20010901164238.P9870@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <OF8E62B3C8.CD1E8E23-ON87256AB9.007E8B1A@boulder.ibm.com> <Pine.GSO.4.21.0109010015380.15931-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.21.0109010015380.15931-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Sat, Sep 01, 2001 at 12:23:05AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 01, 2001 at 12:23:05AM -0400, Alexander Viro wrote:
> > 2) I'd like to see a readonly mount state defined as "the filesystem will
> > not change.  Period."  Not for system calls in progress, not for cache
> > synchronization, not to set an "unmounted" flag, not for writes that are
> > queued in the device driver or device.  (That last one may stretch
> > feasability, but it's a worthy goal anyway).
> 
> It doesn't work.  Think of r/o mounting of remote filesystem.  Do you
> suggest that it should make it impossible to change from other clients?

It's sufficient for local file systems. Or see it this way: The
machine, that mounted it r/o will NOT write to it until it is
mounted r/w again.

I also like the "kill/finish all outstanding writes" idea (kill
or finish should depend on the MNT_FORCE option). Once we've
implemented it, forcible unmount becomes trivial ;-)

Forcible unmount is high on the wish list of several admins I
know.

Regards

Ingo Oeser
