Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136788AbRECMpM>; Thu, 3 May 2001 08:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136794AbRECMpC>; Thu, 3 May 2001 08:45:02 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:33798 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136788AbRECMom>; Thu, 3 May 2001 08:44:42 -0400
Subject: Re: Requirement of make oldconfig [was: Re: [kbuild-devel] Re: CML2 1.3.1, aka ...]
To: vonbrand@inf.utfsm.cl (Horst von Brand)
Date: Thu, 3 May 2001 13:47:25 +0100 (BST)
Cc: stoffel@casc.com (John Stoffel), esr@thyrsus.com, cate@dplanet.ch,
        linux-kernel@vger.kernel.org (CML2),
        kbuild-devel@lists.sourceforge.net
In-Reply-To: <200105031232.f43CW7aA009990@pincoya.inf.utfsm.cl> from "Horst von Brand" at May 03, 2001 08:32:07 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14vIW2-0005US-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > No, we're just asking you to make the CML2 parser more tolerant of old
> > and possibly broken configs.
> 
> It is _much_ easier on everybody involved to just bail out and ask the user
> (once!) to rebuild the configuration from scratch starting from the defaults.

No. Every new kernel changes the constraints so every new kernel you have
to reconfigure from scratch. That also makes it very hard to be sure you got
the results right.

oldconfig has a simple algorithm that works well for current cases

Start at the top of the symbols in file order. If a symbol is new ask the
user. If a symbol is now violating a constraint it gets set according to 
existing constraints if not it gets set to its old value.

Alan

