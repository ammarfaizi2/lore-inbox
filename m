Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129181AbQKHUsi>; Wed, 8 Nov 2000 15:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129656AbQKHUs2>; Wed, 8 Nov 2000 15:48:28 -0500
Received: from kleopatra.acc.umu.se ([130.239.18.150]:20639 "EHLO
	kleopatra.acc.umu.se") by vger.kernel.org with ESMTP
	id <S129181AbQKHUsP>; Wed, 8 Nov 2000 15:48:15 -0500
Date: Wed, 8 Nov 2000 21:47:59 +0100
From: David Weinehall <tao@acc.umu.se>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Pentium IV-summary
Message-ID: <20001108214759.D17544@khan.acc.umu.se>
In-Reply-To: <379322493.973714466779.JavaMail.root@web346-wra.mail.com> <8ucdg5$npt$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <8ucdg5$npt$1@cesium.transmeta.com>; from hpa@zytor.com on Wed, Nov 08, 2000 at 12:36:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2000 at 12:36:21PM -0800, H. Peter Anvin wrote:
> Followup to:  <379322493.973714466779.JavaMail.root@web346-wra.mail.com>
> By author:    Frank Davis <fdavis112@juno.com>
> In newsgroup: linux.dev.kernel
> > 
> > 2. There's a bug in get_model_name(),
> >    cpuid(0x80000001, &dummy, &dummy, &dummy, &(c->x86_capability));
> > 
> > that overwrites the capability state. It will be fixed in 2.2.18 by
> > Dave Jones. Should we also look at Peter Anvin's fix for the problem
> > that Linus mentioned? What are the other features of the Pentium IV
> > should be included in the kernel pending the capability state fix?
> > 
> 
> I'm working on a revamp of the i386 CPUID detection code, which will
> fix this problem as a side effect.

Is this revamp only for processors that actually support the
CPUID-instruction, or will you fix the CPU-detection for non-CPUID
processors too?! There are quite a few processors that can be detected
properly but aren't (for instance, IBM 486slc/slc2/slc3)


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
