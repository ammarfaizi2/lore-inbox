Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267733AbSLTCTe>; Thu, 19 Dec 2002 21:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267736AbSLTCTe>; Thu, 19 Dec 2002 21:19:34 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:28652
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267733AbSLTCT3>; Thu, 19 Dec 2002 21:19:29 -0500
Subject: RE: [PATCH 2.5.52] Use __set_current_state() instead of current->
	state = (take 1)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'Robert Love'" <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C7806CACA31@orsmsx116.jf.intel.com>
References: <A46BBDB345A7D5118EC90002A5072C7806CACA31@orsmsx116.jf.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 20 Dec 2002 03:08:28 +0000
Message-Id: <1040353708.30925.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-12-19 at 19:04, Perez-Gonzalez, Inaky wrote:
> 
> > > And that would now really work when CONFIG_X86_OOSTORE=1 is required
> > > [after all, it is a write, so it'd need the equivalent of a wmb() or
> > > xchg()].
> > 
> > Is this a hint that your employer may have an x86 chip in the future
> > with weak ordering? :)
> 
> Hmmm ... taking into account that there are some many thousands of
> employees in my company and that I know less than one hundred ...
> and that they are all software ... well, I don't think I am into
> the rumour mill :]

Also OOSTORE is there because other vendors already make weak store
order capable x86 processors. One example of this is the Winchip - where
turning off strict store ordering is worth 30% performance.

In addition you have to treat store ordering/locking carefully due to
the pentium pro store fencing errata. (Thats why our < PII kernel
generates lock movb to unlock when in theory the lock isnt needed).

Alan

