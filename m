Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129228AbQKXAJn>; Thu, 23 Nov 2000 19:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131389AbQKXAJe>; Thu, 23 Nov 2000 19:09:34 -0500
Received: from 13dyn232.delft.casema.net ([212.64.76.232]:61963 "EHLO
        abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
        id <S129228AbQKXAJW>; Thu, 23 Nov 2000 19:09:22 -0500
Message-Id: <200011232339.AAA02164@cave.bitwizard.nl>
Subject: Re: PROBLEM: Cruft mounting option incorrect in ISOFS code
In-Reply-To: <200011231818.KAA18647@falcon.csc.calpoly.edu> from Ben Fennema
 at "Nov 23, 2000 10:18:13 am"
To: Ben Fennema <bfennema@falcon.csc.calpoly.edu>
Date: Fri, 24 Nov 2000 00:39:15 +0100 (MET)
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Peel Jeffery S <jeffery.s.peel@intel.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Fennema wrote:
> Rogier Wolff wrote:
> > 
> > Alan Cox wrote:
> > > > under 1 gig in size.  You can exhibit the problem by mounting the dvd movie
> > > > "The World is Not Enough" as it contains a video_ts.vob which is larger than
> > > > 1 gigabyte.  You will see that most of the file lengths are incorrect due to
> > > > the "cruft mounting option" hacking off the high order byte.  There are
> > > > certainly many more movies out there that exhibit this problem so it would
> > > > be a good thing for someone to fix.
> >  
> > > The cruft thing is correct in itself. The size being 4Gb is trivial
> > > to change providing someone can provide a reference to the standards
> > > that say its ok.  So is the limit 4Gig, who documents it ?
> > 
> > Page 137 of DVD Demystified by Jim Taylor says:
> > 
> >   - Individual files must be less than or equal to 1 gigabyte in length.
> 
> The maximum size of a single UDF extent is 2^30-1
> For DVD Video, the data of each file shall be recorded in a single extent.

Hmm. Then the "or equal to" part is "wrong"... 

Yes, My dvd demystified book also says that it needs to be one extent.

				Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
