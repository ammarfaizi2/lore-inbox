Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289075AbSAIXah>; Wed, 9 Jan 2002 18:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289078AbSAIXaT>; Wed, 9 Jan 2002 18:30:19 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:54790 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S289075AbSAIXaF>; Wed, 9 Jan 2002 18:30:05 -0500
Date: Thu, 10 Jan 2002 00:30:01 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: "Eric S. Raymond" <esr@thyrsus.com>
Cc: Doug McNaught <doug@wireboard.com>, linux-kernel@vger.kernel.org,
        greg@kroah.com, felix-dietlibc@fefe.de
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <20020110003001.A25866@devcon.net>
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Doug McNaught <doug@wireboard.com>, linux-kernel@vger.kernel.org,
	greg@kroah.com, felix-dietlibc@fefe.de
In-Reply-To: <200201092005.g09K5OL28043@snark.thyrsus.com> <m3n0zn6ysr.fsf@varsoon.denali.to> <20020109154425.A28755@thyrsus.com> <20020109230704.A25786@devcon.net> <20020109165658.A31246@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020109165658.A31246@thyrsus.com>; from esr@thyrsus.com on Wed, Jan 09, 2002 at 04:56:58PM -0500
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 04:56:58PM -0500, Eric S. Raymond wrote:

> > That's the way it works for network daemons etc. for years.
> This sounds like good advice.  The autoconfigurator is part of CML2,
> which I expect to be distributed with the kernel.  Does that change 
> your advice at all?

Yes, a little bit. Make dmidecode (or whatever you also need for
preparation steps that have to be done as root) a separate package,
which has to be installed before "make autoconfig" works, and write
that down in Documentation/Changes.

This gives you several benefits:

- you don't depend on the version of the /running/ kernel for "make
  autoconfig" to work (/dev/kmem is available for a /long/ time now).
- you can install and run dmidecode on one machine, copy the retrieved
  data to another machine and autoconfigure/build the kernel there.

Distributions can install the package by default, to make it work for
your grandmother as well, if that's what you want.

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
