Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275716AbRJNQUY>; Sun, 14 Oct 2001 12:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275720AbRJNQUP>; Sun, 14 Oct 2001 12:20:15 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:30613 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S275716AbRJNQUD>;
	Sun, 14 Oct 2001 12:20:03 -0400
Date: Sun, 14 Oct 2001 12:20:34 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: mount --bind and -o [re: nosuid/noexec/nodev handling]
In-Reply-To: <20011014191218.Q1074@niksula.cs.hut.fi>
Message-ID: <Pine.GSO.4.21.0110141217000.6026-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Oct 2001, Ville Herva wrote:

> BTW, I just managed get a mount process to unkillable (-9) state while
> playing with --bind. You might be uninterested in details if I can figure
> out how to reproduce it?

I would be _very_ interested in details.  A word of warning, though -
/proc/mounts is b0rken.  If its output grows beyond 4Kb (no matter what
had caused that - lots of NFS mounts, many bindings, etc.) it silently
truncates the output.  Result: deeply confused umount -a.

I'll post the fix as soon as I finish it.  For now too many mountpoints
of any description == confused df and umount -a.

