Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135599AbRDSJ0q>; Thu, 19 Apr 2001 05:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135606AbRDSJ0g>; Thu, 19 Apr 2001 05:26:36 -0400
Received: from 4dyn165.delft.casema.net ([195.96.105.165]:19472 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S135599AbRDSJ0Y>; Thu, 19 Apr 2001 05:26:24 -0400
Message-Id: <200104190926.LAA06753@cave.bitwizard.nl>
Subject: Re: Cross-referencing frenzy
In-Reply-To: <20010419013748.C29686@thyrsus.com> from "Eric S. Raymond" at "Apr
 19, 2001 01:37:48 am"
To: "Eric S. Raymond" <esr@thyrsus.com>
Date: Thu, 19 Apr 2001 11:26:08 +0200 (MEST)
CC: Richard Gooch <rgooch@atnf.csiro.au>, "Edward S. Marshall" <esm@logic.net>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond wrote:
> Richard Gooch <rgooch@atnf.csiro.au>:
> > > Look at the filename. ;-) They're not being kept around, they just
> > > happen to be mentioned in the devfs ChangeLog, and esr's overzealous
> > > crossref tool caught them. *grin*
> 
> I've already fixed that.
>  
> > A cleaner solution is to parse the source code, ignoring comment
> > blocks. However, that's a bit more work.
> 
> Not too hard.  I think I can do that.

Eric, 

I think it should be possible to do: 

/* to enable the special stuff, change the "undef" to "define",
   If you really want you can add this to Config.in so that you're presented
   with this choice when configuring your kernel. But it's not neccesary
   for the general public to always see this toggle.  */
#undef CONFIG_SX_SPECIALSTUFF

#ifdef CONFIG_SX_SPECIALSTUFF
...

#endif


Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
