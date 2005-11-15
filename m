Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbVKODCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbVKODCK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 22:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbVKODCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 22:02:09 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:55019 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932307AbVKODCI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 22:02:08 -0500
Date: Tue, 15 Nov 2005 03:02:04 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Andrew Morton <akpm@osdl.org>
Cc: pbadari@us.ibm.com, linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: 2.6.14 X spinning in the kernel
In-Reply-To: <20051114185751.795b8a3d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0511150258420.24064@skynet>
References: <1132012281.24066.36.camel@localhost.localdomain>
 <20051114161704.5b918e67.akpm@osdl.org> <1132015952.24066.45.camel@localhost.localdomain>
 <20051114173037.286db0d4.akpm@osdl.org> <Pine.LNX.4.58.0511150247160.24064@skynet>
 <20051114185751.795b8a3d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Yes invariably the GPU has crashed and isn't responding to anything.
>
> But radeon_do_wait_for_idle() and radeon_do_wait_for_fifo() have timeouts.
> Should Badari have waited longer?

They timeout, and X usually goes straight back in there again, I can't
remember the codepath exactly at this stage but it just goes round and
round until you kick the machine..

in theory X should probably deal with the situation better... I think it
might be able to at least gracefully die or reset the chip...

> > Also what X was doing etc at the time is invalulable info..
> >
>
> And whether a particualr kernel version introduced this behaviour.

Yes, usually if a kernel introduced it it is because I've done something
really dumb (shouldn't happen too often and with radeons we usually catch
that before stable releases), or because the X server wasn't using DRI
before due to a too old DRM and suddenly the new DRM appears in the kernel
and it uses it ...

There is one known issue with some later version of X on radeons crashing
on PCI GART setups, benh was cooking a patch for X, it isn't something we
can fix in the kernel..

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
Linux kernel - DRI, VAX / pam_smb / ILUG

