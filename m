Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268900AbUIXQkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268900AbUIXQkj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 12:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268968AbUIXQkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 12:40:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:14743 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268957AbUIXQbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 12:31:07 -0400
Date: Fri, 24 Sep 2004 09:30:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
cc: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 8/10] Re: [2.6-BK-URL] NTFS: 2.1.19 sparse annotation,
 cleanups and a bugfix
In-Reply-To: <Pine.LNX.4.60.0409241714190.19983@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.58.0409240926580.32117@ppc970.osdl.org>
References: <Pine.LNX.4.60.0409241707370.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241711400.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712320.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241712490.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713070.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713220.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713380.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241713540.19983@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409241714190.19983@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 Sep 2004, Anton Altaparmakov wrote:
>    
>    - Fix all the sparse bitwise warnings.  Had to change all the enums
>      storing little endian values to #defines because we cannot set enums
>      to be little endian so we had lots of bitwise warnings from sparse.

Btw, Al is fixing this. We'll make enum's properly typed, rather than just 
plain integers. It's not traditional C behaviour, but it gives you better 
type safety, and Al points out that other C compilers (the Plan 9 one, to 
be specific) have done the same thing for similar reasons.

So we'll eventually be able to use enum's instead of #defines without
losing any sparse information.

Of course, the only case where it matters is exactly cases like this, 
where the difference between using an enum and a #define is basically a 
matter of taste. But since I agree that enum's can look a lot nicer, it's 
good to know that it's being worked on.

		Linus
