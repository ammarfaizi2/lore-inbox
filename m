Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129803AbQKXHdo>; Fri, 24 Nov 2000 02:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132082AbQKXHdf>; Fri, 24 Nov 2000 02:33:35 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:34485 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S129803AbQKXHdU>;
        Fri, 24 Nov 2000 02:33:20 -0500
Date: Fri, 24 Nov 2000 02:03:19 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Andre Hedrick <andre@linux-ide.org>
cc: Ion Badulescu <ionut@moisil.cs.columbia.edu>,
        Guest section DW <dwguest@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: ext2 filesystem corruptions back from dead? 2.4.0-test11
In-Reply-To: <Pine.LNX.4.10.10011232216270.4479-100000@master.linux-ide.org>
Message-ID: <Pine.GSO.4.21.0011240148410.12702-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Nov 2000, Andre Hedrick wrote:

[I wrote]
> > ?
> > If you have a l-k feed from future - please share. I'm not saying that
> 
> Date: Thu, 23 Nov 2000 04:37:21 -0500 (EST)
> 
> > fs/* is not the source of that stuff, but I sure as hell had not said
> > that it is. I simply don't know yet.
> 
> You were pointing out changes to reproduce the effect.

Erm... Since then the problem had been reproduced on the patched tree, so
we apparently have something else. Behaviour on disk/quota overflow is
a separate story - even with fixes for that problem stays.

> > > Since there have been not kernel changes to the driver that effect the
> > > code since 2.4.0-test5 or test6 and it now randomly shows up after five or
> > > six revisions out from the change, and the changes were chipset only.
> > 
> > generic_unplug_device() was changed more or less recently. I doubt that
> > it is relevant, but...
> 
> Cool, the issue was that I get tried of people blaming the ATA subsystem
> for things that it does not do or has control over.  Basically, I kill
> bogus threads that try to tag me with an old problem of the past that was
> a hardware issue.

<shrug> I don't see any attempts to tag you (or ATA subsystem, for that matter)
in that thread. And thread is hardly bogus... I agree that changes in
drivers/ide/* are very unlikely to be the source of that, but information
of that kind can help to weed out some of the changes in ll_rw_blk.c.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
