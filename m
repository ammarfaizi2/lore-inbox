Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280448AbRKXXDp>; Sat, 24 Nov 2001 18:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280450AbRKXXDf>; Sat, 24 Nov 2001 18:03:35 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:433 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S280448AbRKXXD2>;
	Sat, 24 Nov 2001 18:03:28 -0500
Date: Sat, 24 Nov 2001 18:03:26 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Robert Boermans <boermans@tfn.net>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.0 breakage even with fix?
In-Reply-To: <3C0027BC.CC76D1D1@tfn.net>
Message-ID: <Pine.GSO.4.21.0111241749320.6117-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 25 Nov 2001, Robert Boermans wrote:

> If the filesystem is marked clean, does that mean that people with
> journalling file systems are fscked? (since there might be no journal entry
> of what hasn't finished.)

Well, if filesystem doesn't have a recovery tool that would allow forced
check mode - you _are_ screwed.  As you will be again and again if you get
memory corruption/driver bugs/fs bugs/RAID bugs/physical disk problems/etc.

Again, if filesystem trusts clear bit to the extent that you have no way
to convince it that checks _are_ needed - it's unfit for any serious use.
I suspect that by now everybody had learnt that much - that used to be
a permanent source of problems with early journalling filesystems and AFAIK
all of them had been fixed since then.

