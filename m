Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289099AbSAJAjZ>; Wed, 9 Jan 2002 19:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289102AbSAJAjO>; Wed, 9 Jan 2002 19:39:14 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:56840 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S289099AbSAJAi6>; Wed, 9 Jan 2002 19:38:58 -0500
Date: Thu, 10 Jan 2002 01:38:56 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Greg KH <greg@kroah.com>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        felix-dietlibc@fefe.de, linux-kernel@vger.kernel.org
Subject: Re: initramfs programs (was [RFC] klibc requirements)
Message-ID: <20020110013856.A26151@devcon.net>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Anton Altaparmakov <aia21@cam.ac.uk>, Greg KH <greg@kroah.com>,
	Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
	felix-dietlibc@fefe.de, linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020109213221.02dd5f80@pop.cus.cam.ac.uk> <5.1.0.14.2.20020109103716.026a0b20@pop.cus.cam.ac.uk> <5.1.0.14.2.20020109103716.026a0b20@pop.cus.cam.ac.uk> <5.1.0.14.2.20020109213221.02dd5f80@pop.cus.cam.ac.uk> <20020109214022.GE21963@kroah.com> <5.1.0.14.2.20020109215335.02cfc780@pop.cus.cam.ac.uk> <20020109231528.B25786@devcon.net> <20020110002507.GU13931@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020110002507.GU13931@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Wed, Jan 09, 2002 at 05:25:07PM -0700
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 09, 2002 at 05:25:07PM -0700, Tom Rini wrote:
> > 
> > This could be done anyway: just replace the initramfs image built by 
> > the kernel build with anotherone built from another source tree. It
> > would be helpful though if the tools were distributed both standalone
> > and included into the kernel tree.
> If the kernel is going to build an initramfs option, it also needs a way
> to be given one.  The issue I'm thinking of is I know of a few platforms
> where the initramfs archive will have to be part of the 'zImage' file
> (much like they do for ramdisks now).

Append it to the zImage and let the kernel look for it there. Plus add
a tool to util-linux (or maybe an option to rdev?) to let you replace
the embedded initramfs in a {,b}zImage with a customized one.

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
