Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268526AbUIPRQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268526AbUIPRQD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 13:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268381AbUIPRLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 13:11:47 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:38352 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268334AbUIPRIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 13:08:30 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: device driver for the SGI system clock, mmtimer
Date: Thu, 16 Sep 2004 10:07:36 -0700
User-Agent: KMail/1.7
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, Christoph Lameter <clameter@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Bob Picco <Robert.Picco@hp.com>, venkatesh.pallipadi@intel.com
References: <200409161003.39258.bjorn.helgaas@hp.com> <200409160909.12840.jbarnes@engr.sgi.com> <1095349940.22739.34.camel@localhost.localdomain>
In-Reply-To: <1095349940.22739.34.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409161007.37015.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, September 16, 2004 8:52 am, Alan Cox wrote:
> On Iau, 2004-09-16 at 17:09, Jesse Barnes wrote:
> > I think Christoph already looked at that.  And HPET doesn't provide mmap
> > functionality, does it?  I.e. allow a userspace program to dereference
> > the counter register directly?
>
> It can do but that assumes nothing else is mapped into the same page
> that would be harmful or reveal information that should not be revealed
> etc..

And what about the register layout?  mmtimer makes sure that the register is 
on a page by itself before it allows the mmap, and only exports the counter 
register itself.  Can hpet do that?

Jesse
