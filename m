Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbUCXTjm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 14:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbUCXTjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 14:39:42 -0500
Received: from hera.kernel.org ([63.209.29.2]:18318 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S263163AbUCXTji (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 14:39:38 -0500
Date: Wed, 24 Mar 2004 17:39:15 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Matthew Wilcox <willy@debian.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'Jeff Garzik'" <jgarzik@pobox.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH][RELEASE] megaraid 2.10.2 Driver
Message-ID: <20040324203915.GH5551@logos.cnet>
References: <0E3FA95632D6D047BA649F95DAB60E570230C77B@exa-atlanta.se.lsil.com> <20040323004543.GP25059@parcelfarce.linux.theplanet.co.uk> <20040323062708.A29405@infradead.org> <20040323133035.GU25059@parcelfarce.linux.theplanet.co.uk> <20040324061553.GA13681@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040324061553.GA13681@logos.cnet>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Mar 23, 2004 at 01:30:35PM +0000, Matthew Wilcox wrote:
> > On Tue, Mar 23, 2004 at 06:27:08AM +0000, Christoph Hellwig wrote:
> > > On Tue, Mar 23, 2004 at 12:45:43AM +0000, Matthew Wilcox wrote:
> > > > I don't think you understand how CONFIG_COMPAT works.  x86-64 defines it
> > > > when it wants it:
> > > 
> > > But not in 2.4, and this is a 2.4-only patch..
> > 
> > It is?  I didn't see that mentioned anywhere.
> > 
> > Anyway, it's wrong to define LSI_CONFIG_COMPAT based solely on __x86_64__.
> > You'd also need to check IA32_EMULATION.  Really, it would be simpler
> > to add CONFIG_COMPAT to 2.4.

I think is ok to use such XXX_CONFIG_COMPAT and #ifdef the register_ioctl calls 
around it in the driver. Acceptable for 2.4. Comments?  

I think you are right about checking for IA32_EMULATION too. 

Does SPARC also define it?

The MPT fusion driver currently does:

#if (defined(__sparc__) && defined(__sparc_v9__)) || defined(__x86_64__)
#define MPT_CONFIG_COMPAT
#endif

Sreenivas: about the megaraid2 update, please work on the commentaries by Jeff.

