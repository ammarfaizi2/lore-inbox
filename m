Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129784AbRAQA2o>; Tue, 16 Jan 2001 19:28:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130032AbRAQA2f>; Tue, 16 Jan 2001 19:28:35 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:60427 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129784AbRAQA2Z>; Tue, 16 Jan 2001 19:28:25 -0500
Date: Tue, 16 Jan 2001 18:28:06 -0600
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: "James H. Cloos Jr." <cloos@jhcloos.com>, linux-kernel@vger.kernel.org
Subject: Re: named streams, extended attributes, and posix
Message-ID: <20010116182806.B6364@cadcamlab.org>
In-Reply-To: <3A5E10F5.716F83B7@holly-springs.nc.us> <m3snmpgu8t.fsf@austin.jhcloos.com> <3A6466D0.6587C11A@holly-springs.nc.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3A6466D0.6587C11A@holly-springs.nc.us>; from rothwell@holly-springs.nc.us on Tue, Jan 16, 2001 at 10:20:48AM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Michael Rothwell]
> It seems that if you move a file with a colon -- "file:colon" -- in
> the name from Ext2 to "StreamFS," you would end up with a file named
> "file" with a stream named "colon". When copying back, you would get
> "file:colon" back.

What if you copy both 'filename' and 'filename:ext' onto the same fs?
Do they get combined into one file?  That to me violates principle of
least surprise.  The fs should just mangle filenames it doesn't agree
with, like the existing legacy filesystems already do.

Any semantics by which 'filename:stream' and 'filename' refer to the
same file would be b0rken.  If instead you use 'filename/stream'
syntax, at least that is an illegal filename on *all* Linux
filesystems, so this particular point of confusion does not come up.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
