Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWFTPpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWFTPpM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 11:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWFTPpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 11:45:11 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:48815 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751338AbWFTPpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 11:45:07 -0400
Date: Tue, 20 Jun 2006 17:44:57 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Matthew Wilcox <matthew@wil.cx>
cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       webmaster@cyberdogtech.com
Subject: Re: [PATCH] Unify CONFIG_LBD and CONFIG_LSF handling
In-Reply-To: <20060620145234.GK1630@parisc-linux.org>
Message-ID: <Pine.LNX.4.64.0606201742280.12900@scrub.home>
References: <20060619221618.GJ1630@parisc-linux.org>
 <Pine.LNX.4.64.0606201616430.17704@scrub.home> <20060620145234.GK1630@parisc-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 20 Jun 2006, Matthew Wilcox wrote:

> On Tue, Jun 20, 2006 at 04:20:53PM +0200, Roman Zippel wrote:
> > Hi,
> > 
> > On Mon, 19 Jun 2006, Matthew Wilcox wrote:
> > >  config LSF
> > >  	bool "Support for Large Single Files"
> > > -	depends on X86 || (MIPS && 32BIT) || PPC32 || ARCH_S390_31 || SUPERH || UML
> > > +	depends on !64BIT
> > >  	help
> > >  	  Say Y here if you want to be able to handle very large files (bigger
> > >  	  than 2TB), otherwise say N.
> > 
> > While you're at it, could you please take care of bug #6719 and fix the 
> > LSF help text?
> > Thanks.
> 
> I don't really understand the complaint.  If <rare condition applies>,
> say Y, otherwise say N.  If unsure, say Y.  The default is N.  Perhaps
> all that's needed is to spell out the implications of saying Y?  How
> about:
> 
> 	  This option allows 32-bit systems to support files larger than
> 	  2 Terabytes, at a cost of increased kernel memory usage.  Most
> 	  people do not need the overhead and should answer N to this
> 	  question, but if you do not understand this question, answering
> 	  Y is safest.
> 
> Or is that too verbose?

How likely is it that someone who doesn't understand the question needs 
this option? I think N is a safe answer here.

bye, Roman
