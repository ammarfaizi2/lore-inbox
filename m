Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVAMKQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVAMKQp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 05:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261551AbVAMKQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 05:16:45 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:51983 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261553AbVAMKQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 05:16:30 -0500
Date: Thu, 13 Jan 2005 11:05:42 +0100
From: Willy Tarreau <willy@w.ods.org>
To: David Lang <david.lang@digitalinsight.com>
Cc: Matt Mackall <mpm@selenic.com>, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050113100541.GA10829@alpha.home.local>
References: <20050112161227.GF32024@logos.cnet> <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org> <20050112205350.GM24518@redhat.com> <Pine.LNX.4.58.0501121750470.2310@ppc970.osdl.org> <20050112182838.2aa7eec2.akpm@osdl.org> <20050113033542.GC1212@redhat.com> <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org> <20050113072851.GN2995@waste.org> <20050113074234.GJ7048@alpha.home.local> <Pine.LNX.4.60.0501122359190.20576@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0501122359190.20576@dlang.diginsite.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 12:02:01AM -0800, David Lang wrote:
> >That's why some hardened distros ship with everything R/O (except var) 
> >and
> >/var non-exec.
> 
> this only works if you have no reason to mix the non-exec and R/O stuff 
> in the same directory (there is some software that has paths for stuff 
> hard coded that will not work without them being togeather)

Symlinks are the solution against this breakage. And if your software comes
from the dos world where temporary files are stored in the same directory
as the binaries (remember SET TEMP=C:\DOS ?) then you have no possibility at
all, but the application design by itself should be frightening enough to keep
away from it.

> also it gives you no ability to maintain the protection for normal users 
> at the same time that an admin updates the system. Linus's proposal would 
> let you five this cap to the normal users, but still let the admin manage 
> the box normally.

That's perfectly true. What I explained was not meant to be a universal
solution, but an easy step forward.

Willy

