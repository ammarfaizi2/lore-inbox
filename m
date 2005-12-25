Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbVLYUjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbVLYUjg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 15:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750917AbVLYUjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 15:39:36 -0500
Received: from mylar.outflux.net ([69.93.193.226]:27802 "EHLO
	mylar.outflux.net") by vger.kernel.org with ESMTP id S1750902AbVLYUjg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 15:39:36 -0500
Date: Sun, 25 Dec 2005 12:39:30 -0800
From: Kees Cook <kees@outflux.net>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib: zlib_inflate "r.base" uninitialized compile warnings
Message-ID: <20051225203929.GP18040@outflux.net>
References: <20051225180758.GM18040@outflux.net> <20051225183406.GB27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051225183406.GB27946@ftp.linux.org.uk>
X-HELO: ghostship.outflux.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 25, 2005 at 06:34:06PM +0000, Al Viro wrote:
> NAK.  That sort of patches is only going to hide real problems in the
> code where such warnings are _not_ false positives.
> 
> Let me put it that way: what bug are you fixing in that patch?  Is
> there a codepath that would lead to use of r without initialization?
> If there is - show it; if there is not - why are you patching kernel
> and not gcc?

Well, good point.  My only question would be: why are other 
"uninitialized" variables masked in the same way in that code?

Also, perhaps the phrasing in SubmittingPatches should be changed.  
Currently (for "trivial" patches) it says:

 Warning fixes (cluttering with useless warnings is bad)

Is that warning considered "useful"?  Should this hint, instead, read:

 Warning fixes (make sure the warning is "real", if not, patch gcc)

:)

-- 
Kees Cook                                            @outflux.net
