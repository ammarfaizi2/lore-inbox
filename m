Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbSKYXwb>; Mon, 25 Nov 2002 18:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266115AbSKYXwb>; Mon, 25 Nov 2002 18:52:31 -0500
Received: from sweetums.bluetronic.net ([24.199.150.42]:31397 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S262812AbSKYXwa>; Mon, 25 Nov 2002 18:52:30 -0500
Date: Mon, 25 Nov 2002 18:59:45 -0500 (EST)
From: Ricky Beam <jfbeam@bluetronic.net>
To: sean darcy <seandarcy@hotmail.com>
cc: <linux-kernel@vger.kernel.org>, <rusty@rustcorp.com.au>
Subject: Re: modutils for both  redhat kernels and 2.5.x
In-Reply-To: <F173CabEMPhzzk3Tco30000ed9f@hotmail.com>
Message-ID: <Pine.GSO.4.33.0211251830050.6708-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Nov 2002, sean darcy wrote:
>I've tried to use modutils-2.4.21-4 - which uses the new module loading in
>2.5.49 and is backward compatible with 2.4.x. I works fine, except for the
>redhat kernels.
>
>I realize that nobody said it had to work with a particular distro, just
>like to know if anybody has a work around.

No, but then again, the module-init-tools don't come anywhere close to the
same interface or functionality that exists (and has existed for a good
long time, btw) with the modutils.

I would beg and plead with Linus to back that "crap" out of the kernel
until such time as it has a snowball's chance of actually working ...
anywhere.  As it stands, 2.5 is now 100% unusable until modules works
again.

Kernel symbol versioning no longer exists.  Depmod no longer exists.
Modprobe blindly loads a string of modules without even looking to see
if it's already loaded.  The command line args for modprobe are laughingly
few (and none of the ones a redhat system needs to boot are implemented.)
We're back to the flat module namespace (that patch of earth is now 100%
salt...)  And every single object that forms a module will need to be
retooled to adhere to the new module API -- this is a brick wall no one
needs right now; there are *still* drivers in the tree that haven't been
updated to the new DMA interface and that's been pushed for months (years?)

Just when things begin to work, Linus puts on his sadist hat and makes
everything stop working again.  Aren't we in the midst of a feature/code
freeze so the "ship it" label can be slapped on this thing?

--Ricky


