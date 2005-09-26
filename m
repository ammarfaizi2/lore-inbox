Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750724AbVIZUn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750724AbVIZUn1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 16:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbVIZUn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 16:43:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4308 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750724AbVIZUn0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 16:43:26 -0400
Date: Mon, 26 Sep 2005 13:43:15 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 1/4] NTFS: Fix sparse warnings that have crept in over
 time.
In-Reply-To: <Pine.LNX.4.60.0509262005430.29344@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.58.0509261334390.3308@g5.osdl.org>
References: <Pine.LNX.4.60.0509261427520.32257@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0509261431270.32257@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.58.0509260746130.3308@g5.osdl.org>
 <Pine.LNX.4.60.0509261654550.29344@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.58.0509260926160.3308@g5.osdl.org>
 <Pine.LNX.4.60.0509262005430.29344@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 26 Sep 2005, Anton Altaparmakov wrote:
> > 
> > I'm actually a bit surprised that the cast even shut sparse up. It
> > probably shouldn't have, and it should have complained about casting an
> > unknown type even _with_ your added cast (ie I think it should have cut
> > your four lines of warning down to one).
> > 
> > Did it?
> 
> No, the warnings completely disappeared with the cast.

Ok, it turns out that a bad enum type ends up being seen as just its 
integer type, and anything that doesn't care about anything else than its 
size (namely, a cast) won't even complain.

That's very arguably a bug. Oh, well. Not a big one.

		Linus
