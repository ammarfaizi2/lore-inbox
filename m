Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282707AbRLQU07>; Mon, 17 Dec 2001 15:26:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282771AbRLQU0t>; Mon, 17 Dec 2001 15:26:49 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:28658 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S282707AbRLQU0j>;
	Mon, 17 Dec 2001 15:26:39 -0500
Date: Mon, 17 Dec 2001 15:26:37 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "Grover, Andrew" <andrew.grover@intel.com>
cc: "'otto.wyss@bluewin.ch'" <otto.wyss@bluewin.ch>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Booting a modular kernel through a multiple streams file
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D7FD@orsmsx111.jf.intel.com>
Message-ID: <Pine.GSO.4.21.0112171520150.3992-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 Dec 2001, Grover, Andrew wrote:

> I don't think multiple streams is a good idea, but did you all see the patch
> by Christian Koenig to let the bootloader load modules? That seems to solve
> the problem nicely.

That puts an awful lot of smarts into bootloader and creates code duplication
for no good reason.

We _already_ have code for loading modules.  And it's going to stay, no
matter what happens on boot.  So why the hell duplicate that in $BIGNUM
unrelated pieces of software (LILO, SYSLINUX, MILO, SILO, etc.)?  Just
to create extra fun with debugging?

