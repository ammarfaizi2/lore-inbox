Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129518AbQKXVRq>; Fri, 24 Nov 2000 16:17:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129866AbQKXVRg>; Fri, 24 Nov 2000 16:17:36 -0500
Received: from xanax.marginal.net ([156.46.26.140]:13060 "EHLO
        xanax.marginal.net") by vger.kernel.org with ESMTP
        id <S129518AbQKXVRT>; Fri, 24 Nov 2000 16:17:19 -0500
Date: Fri, 24 Nov 2000 14:46:30 -0600
From: "Nathan A. Ferch" <nf+linux-kernel@marginal.net>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Hakan Lennestal <hakanl@cdt.luth.se>,
        Peter Samuelson <peter@cadcamlab.org>,
        Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0, test10, test11: HPT366 problem
Message-ID: <20001124144630.A961@marginal.net>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
        Hakan Lennestal <hakanl@cdt.luth.se>,
        Peter Samuelson <peter@cadcamlab.org>,
        Andre Hedrick <andre@linux-ide.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20001121122617.88D1A26@ganymede.cdt.luth.se> <27102.974813391@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <27102.974813391@redhat.com>; from dwmw2@infradead.org on Tue, Nov 21, 2000 at 01:29:51PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have similar problems with an IBM-DTLA-305020 and the HPT-366 on a ABIT BP6.
I'm not sure what the BIOS version is, i'll check it once i return home.
Changing to udma3 seems to fix the problems. However i can always pass
partition check fine.

On Tue, Nov 21, 2000 at 01:29:51PM +0000, David Woodhouse wrote:
> 
> hakanl@cdt.luth.se said:
> >  When it comes to the partition detection during bootup, udma4 or
> > udma3 doesn't seem to matter. It passes approx. one out of ten times
> > either way. 
> 
> How have you made it use udma3 at bootup? Something like the patch below?
> 
> Index: drivers/ide/hpt366.c
> ===================================================================
> RCS file: /inst/cvs/linux/drivers/ide/Attic/hpt366.c,v
> retrieving revision 1.1.2.10
> diff -u -r1.1.2.10 hpt366.c
> --- drivers/ide/hpt366.c	2000/11/10 14:56:31	1.1.2.10
> +++ drivers/ide/hpt366.c	2000/11/21 13:27:32
> @@ -55,6 +55,8 @@
>  };
>  
>  const char *bad_ata66_4[] = {
> +	"IBM-DTLA-307045",
> +	"IBM-DTLA-307030",
>  	"WDC AC310200R",
>  	NULL
>  };
> 
> --
> dwmw2
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
--
nathan a ferch
nf@marginal.net
"No!  Nobody ever built them like this!  The architect was either an authentic whacko or a certified genius.  The whole building is like a huge antenna for pulling in and concentrating psychokinetic energy." -Stantz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
