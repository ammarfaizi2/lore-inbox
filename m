Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278428AbRLBNxZ>; Sun, 2 Dec 2001 08:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278690AbRLBNxP>; Sun, 2 Dec 2001 08:53:15 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:54233 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S278428AbRLBNxC>; Sun, 2 Dec 2001 08:53:02 -0500
Date: Sun, 2 Dec 2001 14:53:00 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Keith Owens <kaos@ocs.com.au>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.4.17.2: make ext2 smaller
Message-ID: <20011202145300.B741@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3C0A1105.18B76D64@mandrakesoft.com> <25560.1007294074@ocs3.intra.ocs.com.au> <20011202133314.B717@nightmaster.csn.tu-chemnitz.de> <3C0A269F.D2B1D3@mandrakesoft.com> <20011202144019.A741@nightmaster.csn.tu-chemnitz.de> <3C0A310E.513903CB@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3C0A310E.513903CB@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sun, Dec 02, 2001 at 08:47:58AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2001 at 08:47:58AM -0500, Jeff Garzik wrote:
> Ingo Oeser wrote:
> > 
> > On Sun, Dec 02, 2001 at 08:03:27AM -0500, Jeff Garzik wrote:
> > > And if !MODULE, then even EXPORT_SYMBOL symbols can become static, if
             ~~~~~~~[1]
> > > they are not used outside the compilation unit.
> > 
> > If your compilation units are greater than the current
> > granularity of modules: Yes.
> > 
> > EXPORT_SYMBOL() symbols are Kernel-API, which is also exported to
> > 3rd-party vendors with binary modules. So it makes little sense
> > to me to make them static.
> 
> If !MODULES, modules are not supported by that kernel.  It is completely
     ~~~~~~~~[2]
> safe to make such functions static, if not used outside the compilation
> unit.  For all other cases, it is indeed wrong to make such them static.

Ahh! I thought with [1] you meant, that the compilation unit is
not compiled as a module. But with [2] it makes a lot of sense of
course ;-)

Sorry for my confusion.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
