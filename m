Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282873AbRLBNsZ>; Sun, 2 Dec 2001 08:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282876AbRLBNsP>; Sun, 2 Dec 2001 08:48:15 -0500
Received: from mail026.mail.bellsouth.net ([205.152.58.66]:52902 "EHLO
	imf26bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S282873AbRLBNsD>; Sun, 2 Dec 2001 08:48:03 -0500
Message-ID: <3C0A310E.513903CB@mandrakesoft.com>
Date: Sun, 02 Dec 2001 08:47:58 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
CC: Keith Owens <kaos@ocs.com.au>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.4.17.2: make ext2 smaller
In-Reply-To: <3C0A1105.18B76D64@mandrakesoft.com> <25560.1007294074@ocs3.intra.ocs.com.au> <20011202133314.B717@nightmaster.csn.tu-chemnitz.de> <3C0A269F.D2B1D3@mandrakesoft.com> <20011202144019.A741@nightmaster.csn.tu-chemnitz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:
> 
> On Sun, Dec 02, 2001 at 08:03:27AM -0500, Jeff Garzik wrote:
> > Ingo Oeser wrote:
> > > Even this doesn't have to be done manually. Everything that is
> > > not covered by EXPORT_SYMBOL() in this case can be static, since
> >
> > And if !MODULE, then even EXPORT_SYMBOL symbols can become static, if
> > they are not used outside the compilation unit.
> 
> If your compilation units are greater than the current
> granularity of modules: Yes.
> 
> EXPORT_SYMBOL() symbols are Kernel-API, which is also exported to
> 3rd-party vendors with binary modules. So it makes little sense
> to me to make them static.

If !MODULES, modules are not supported by that kernel.  It is completely
safe to make such functions static, if not used outside the compilation
unit.  For all other cases, it is indeed wrong to make such them static.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

