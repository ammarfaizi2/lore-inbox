Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319256AbSHNRgg>; Wed, 14 Aug 2002 13:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319257AbSHNRgg>; Wed, 14 Aug 2002 13:36:36 -0400
Received: from users.linvision.com ([62.58.92.114]:23434 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S319256AbSHNRgf>; Wed, 14 Aug 2002 13:36:35 -0400
Date: Wed, 14 Aug 2002 19:40:19 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 4/21] fix ARCH_HAS_PREFETCH
Message-ID: <20020814194019.A31761@bitwizard.nl>
References: <3D56B13A.D3F741D1@zip.com.au> <Pine.NEB.4.44.0208132322340.1351-100000@mimas.fachschaften.tu-muenchen.de> <ajc095$hk1$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajc095$hk1$1@cesium.transmeta.com>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 03:12:53PM -0700, H. Peter Anvin wrote:
> Followup to:  <Pine.NEB.4.44.0208132322340.1351-100000@mimas.fachschaften.tu-muenchen.de>
> By author:    Adrian Bunk <bunk@fs.tum.de>
> In newsgroup: linux.dev.kernel
> > >
> > > Because the compiler sees:
> > >
> > > 	for (i = 0; i < N; i++)
> > > 		;
> > >
> > > and it says "ah ha.  A busy wait delay loop" and leaves it alone.
> > >
> > > It's actually a special-case inside the compiler to not optimise
> > > away such constructs.
> > 
> > Why is this a special case? As long as a compiler can't prove that the
> > computed value of i isn't used later it mustn't optimize it away.
> > 
> 
> Bullsh*t.  It can legitimately transform it into:
> 
> 	   i = N;

Right! But people are confusing "practise", "published interface", and 
"spec" again. 

Published interface in this case is that gcc will not optimize an empty
loop away, as it is often used to generate a timing loop. 

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
