Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129091AbQKWStg>; Thu, 23 Nov 2000 13:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129097AbQKWSt1>; Thu, 23 Nov 2000 13:49:27 -0500
Received: from falcon.csc.calpoly.edu ([129.65.242.5]:43431 "EHLO
        falcon.csc.calpoly.edu") by vger.kernel.org with ESMTP
        id <S129091AbQKWStM>; Thu, 23 Nov 2000 13:49:12 -0500
From: Ben Fennema <bfennema@falcon.csc.calpoly.edu>
Message-Id: <200011231818.KAA18647@falcon.csc.calpoly.edu>
Subject: Re: PROBLEM: Cruft mounting option incorrect in ISOFS code
To: R.E.Wolff@BitWizard.nl (Rogier Wolff)
Date: Thu, 23 Nov 2000 10:18:13 -0800 (PST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        jeffery.s.peel@intel.com (Peel Jeffery S),
        linux-kernel@vger.kernel.org ('linux-kernel@vger.kernel.org')
In-Reply-To: <200011231004.LAA06628@cave.bitwizard.nl> from "Rogier Wolff" at Nov 23, 2000 11:04:48 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff wrote:
> 
> Alan Cox wrote:
> > > under 1 gig in size.  You can exhibit the problem by mounting the dvd movie
> > > "The World is Not Enough" as it contains a video_ts.vob which is larger than
> > > 1 gigabyte.  You will see that most of the file lengths are incorrect due to
> > > the "cruft mounting option" hacking off the high order byte.  There are
> > > certainly many more movies out there that exhibit this problem so it would
> > > be a good thing for someone to fix.
>  
> > The cruft thing is correct in itself. The size being 4Gb is trivial
> > to change providing someone can provide a reference to the standards
> > that say its ok.  So is the limit 4Gig, who documents it ?
> 
> Page 137 of DVD Demystified by Jim Taylor says:
> 
>   - Individual files must be less than or equal to 1 gigabyte in length.

The maximum size of a single UDF extent is 2^30-1
For DVD Video, the data of each file shall be recorded in a single extent.

So thats where the limit comes from :)

Ben

-- 
Linux UDF - http://linux-udf.sourceforge.net
Latest Is - udf-0.9.2.1 (http://www.csc.calpoly.edu/~bfennema/udf.html)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
