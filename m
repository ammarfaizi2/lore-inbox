Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144416AbRA1Wug>; Sun, 28 Jan 2001 17:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144431AbRA1Wu1>; Sun, 28 Jan 2001 17:50:27 -0500
Received: from mx2out.umbc.edu ([130.85.253.52]:13759 "EHLO mx2out.umbc.edu")
	by vger.kernel.org with ESMTP id <S144416AbRA1WuW>;
	Sun, 28 Jan 2001 17:50:22 -0500
Date: Sun, 28 Jan 2001 17:50:20 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Alec Smith <alec@shadowstar.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Moving from kernel 2.2 to 2.4
In-Reply-To: <5.0.2.1.2.20010128172921.01f735c0@bugs.home.shadowstar.net>
Message-ID: <Pine.SGI.4.31L.02.0101281745060.746028-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Jan 2001, Alec Smith wrote:

> I understand a large portion of the kernel 2.4 networking code was updated
> and/or completely replaced. Under 2.2 I have ipchains configured to do
> basic masquerading for my local LAN. Is there a straightforward guide which
> describes how to do masquerading and firewalling with 2.4 after moving up
> from 2.2?

http://netfilter.kernelnotes.org/unreliable-guides/

In general, you _have to_ upgrade modutils to at least a 2.3.x revision.

If you use devfs, you almost have to install devfsd, and you really need
to upgrade util-linux (there's a bug in older versions of /bin/login that
barf on the new tty scheme).

I usually do it by compiling and installing a 2.4 kernel; compiling,
installing devfsd (and adding an entry very early in rc.sysinit for it);
installing modutils; and installing util-linux -- then rebooting to test
the new kernel.


--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
