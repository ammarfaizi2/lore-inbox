Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267480AbRGQWOw>; Tue, 17 Jul 2001 18:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267481AbRGQWOl>; Tue, 17 Jul 2001 18:14:41 -0400
Received: from ECE.CMU.EDU ([128.2.236.200]:61341 "EHLO ece.cmu.edu")
	by vger.kernel.org with ESMTP id <S267480AbRGQWOc>;
	Tue, 17 Jul 2001 18:14:32 -0400
Date: Tue, 17 Jul 2001 18:14:26 -0400 (EDT)
From: Craig Soules <soules@happyplace.pdl.cmu.edu>
To: Hans Reiser <reiser@namesys.com>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: NFS Client patch
In-Reply-To: <3B54B5F9.8484715F@namesys.com>
Message-ID: <Pine.LNX.3.96L.1010717180713.13980K-100000@happyplace.pdl.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2001, Hans Reiser wrote:
> I take issue with the word "properly".  We have bastardized our FS design to do it.  NFS should not
> be allowed to impose stable cookie maintenance on filesystems, it violates layering.  Simply
> returning the last returned filename is so simple to code, much simpler than what we have to do to
> cope with cookies.  Linux should fix the protocol for NFS, not ask Craig to screw over his FS
> design.  Not that I think that will happen.....

Unfortunately to comply with NFSv2, the cookie cannot be larger than
32-bits.  I believe this oversight has been correct in later NFS versions.

I do agree that forcing the underlying fs to "fix" itself for NFS is the
wrong solution. I can understand their desire to follow unix semantics
(although I don't entirely agree with them), so until I think up a more
palatable solution for the linux community, I will just keep my patches to
myself :)

Craig

