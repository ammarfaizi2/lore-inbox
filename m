Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135908AbRAHLHp>; Mon, 8 Jan 2001 06:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135562AbRAHLHf>; Mon, 8 Jan 2001 06:07:35 -0500
Received: from kleopatra.acc.umu.se ([130.239.18.150]:33270 "EHLO
	kleopatra.acc.umu.se") by vger.kernel.org with ESMTP
	id <S132903AbRAHLHS>; Mon, 8 Jan 2001 06:07:18 -0500
Date: Mon, 8 Jan 2001 12:07:08 +0100
From: David Weinehall <tao@acc.umu.se>
To: Wayne.Brown@altec.com
Cc: Nick Holloway <Nick.Holloway@pyrites.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Change of policy for future 2.2 driver submissions
Message-ID: <20010108120708.C4991@khan.acc.umu.se>
In-Reply-To: <862569CE.001C2A47.00@smtpnotes.altec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <862569CE.001C2A47.00@smtpnotes.altec.com>; from Wayne.Brown@altec.com on Sun, Jan 07, 2001 at 10:52:48PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 10:52:48PM -0600, Wayne.Brown@altec.com wrote:
> 
> 
> Actually, I have another reason for using patch-kernel, besides being
> inexperienced or lazy:  being weird.  :-)  For some reason, I have an
> aversion to downloading complete kernels, and just grab the patches.
> That's usually OK, because I apply each patch one at a time, within a
> few hours after it comes out.  But once in a while I mess up and have
> to start over -- like a few days ago, when I forgot to reverse
> prelease-diff before trying to apply 2.4.0-prelease-to-final.  I got

You know, there are reasons why patch has an option called --dry-run...

bzcat patch-2.4.0.bz2 | patch -p1 --dry-run
[and if everything goes well]
bzcat patch-2.4.0.bz2 | patch -p1
[will be relatively painless, as the files will be cached by now...]

Is the way I usually apply patches. 

Oh, and after applying a patch I always rename the directory to match
the version of the patch. This way I always know if I have to unapply
any pre-patches/test-patches/whatever.

> the kernel source tree hosed up so badly that I decided to blow it all
> away and get a clean copy.  Instead of doing the sensible thing --
> getting a fresh copy of 2.4.0 -- I untarred 2.2.16 (the most recent
> tarball I had), reverse-patched it down to 2.2.8, applied
> patch-2.2.8-to-2.3.0, used patch-kernel to get up to 2.3.51, then
> applied the patches for 2.3.99-pre1 through -pre9 and 2.4.0-test1
> through -test12, and finally 2.4.0-prelease and
> 2.4.0-prerelease-to-final.  Sure, it's insane, but it's not as tedious

Yup, you're one sick little puppy. Way cool :^)

> as it sounds, since I put together a script to do all this (and it
> doesn't take all that long on my Pentium III, especially if I shut
> down X first).  Anyway, I've kind of been hoping that now that 2.4.0
> is out, maybe future patches will go back to the x.y.z format so I
> could just let patch-kernel do everything.


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
