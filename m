Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135711AbRD2LOg>; Sun, 29 Apr 2001 07:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135714AbRD2LO0>; Sun, 29 Apr 2001 07:14:26 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:28867 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S135711AbRD2LOT>;
	Sun, 29 Apr 2001 07:14:19 -0400
Message-ID: <3AEBF782.1911EDD2@mandrakesoft.com>
Date: Sun, 29 Apr 2001 07:14:10 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
In-Reply-To: <Pine.LNX.4.33.0104281752290.10866-100000@localhost.localdomain> <20010428215301.A1052@gruyere.muc.suse.de> <200104282256.f3SMuRW15999@vindaloo.ras.ucalgary.ca> <9cg7t7$gbt$1@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:
> 
> Followup to:  <200104282256.f3SMuRW15999@vindaloo.ras.ucalgary.ca>
> By author:    Richard Gooch <rgooch@ras.ucalgary.ca>
> In newsgroup: linux.dev.kernel
> > >
> > > In x86-64 there are special vsyscalls btw to solve this problem that export
> > > a lockless kernel gettimeofday()
> >
> > Whatever happened to that hack that was discussed a year or two ago?
> > The one where (also on IA32) a magic page was set up by the kernel
> > containing code for fast system calls, and the kernel would write
> > calibation information to that magic page. The code written there
> > would use the TSC in conjunction with that calibration data.
> >
> > There was much discussion about this idea, even Linus was keen on
> > it. But IIRC, nothing ever happened.
> >
> 
> We discussed this at the Summit, not a year or two ago.  x86-64 has
> it, and it wouldn't be too bad to do in i386... just noone did.

It came up long before that.  I refer to the technique in a post dated
Nov 17, even though I can't find the original. 
http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg13584.html

Initiated by a post from (iirc) Dean Gaudet, we found out that
gettimeofday was one particular system call in the Apache fast path that
couldn't be optimized well, or moved out of the fast path.  After a
couple of suggestions for improving things, Linus chimed in with the
magic page suggestion.

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
