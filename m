Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131647AbQK0DG6>; Sun, 26 Nov 2000 22:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131949AbQK0DGs>; Sun, 26 Nov 2000 22:06:48 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:2577 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S131647AbQK0DGl>; Sun, 26 Nov 2000 22:06:41 -0500
Date: Sun, 26 Nov 2000 20:33:34 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Ford <david@linux.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] modutils 2.3.20 and beyond
Message-ID: <20001126203334.C2535@vger.timpanogas.org>
In-Reply-To: <3A21A720.75A4EEB1@linux.com> <E140Dlm-0002bT-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <E140Dlm-0002bT-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Nov 27, 2000 at 02:11:49AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 02:11:49AM +0000, Alan Cox wrote:
> > > Anaconda will barf and require over 850+ changes to the scripts without
> > > it.  If you look at the patch, you will note that it's a silent switch
> > > that's only there to avoid a noisy error message from depmod.  It
> > > actually does nothing other than set a flag that also does nothing.
> > > -m simply maps to -F.
> > 
> > It's still a bad precedent.  Anaconda should have been written correctly in
> > the first place.
> 
> I don't know if its an Anaconda issue or a limitation in the tools. Keith is
> the modutils maintainer and its up to the Anaconda hackers to prove to him that
> he has a problem so I think he is absolutely right in refusing to change it
> until that is proven

Oddly, the tools already provide the capability needed by anaconda, just 
not in the format the anaconda scripts and code expect.  i.e., anaconda 
is using -m in place of -F, and somewhere down the line someone needed 
to force depmod checks of modules against mismatched kernels (???) which is
probably left over from some point when RedHat was shipping default
kernels "naked" (without modversions).  That's the only justification
I can see for having -i at all, and since I come from a binary compatible
world, I can kindof understand why someone would have needed this 
to support loading of binary modules accross versions (before modversions 
became widely used).  I don't know how to take the "anaconda hacker" moniker.

Jeff






> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
