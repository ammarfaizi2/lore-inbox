Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932291AbWHVPBG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWHVPBG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 11:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWHVPBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 11:01:05 -0400
Received: from ns1.suse.de ([195.135.220.2]:41603 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932291AbWHVPBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 11:01:03 -0400
From: Andi Kleen <ak@suse.de>
To: Tim Hockin <thockin@google.com>
Subject: Re: PCI MMCONFIG aperture size
Date: Tue, 22 Aug 2006 17:00:44 +0200
User-Agent: KMail/1.9.3
Cc: matthew@wil.cx, greg@kroah.com,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@google.com>
References: <20060822024237.GO16573@google.com> <200608220955.31620.ak@suse.de> <20060822145802.GR16573@google.com>
In-Reply-To: <20060822145802.GR16573@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608221700.44690.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 August 2006 16:58, Tim Hockin wrote:
> On Tue, Aug 22, 2006 at 09:55:31AM +0200, Andi Kleen wrote:
> > 
> > > This says to me that (as long as the MCFG table has an End Bus Number of
> > > 31) a 32 MB decode area (32 MB aligned, too) is valid.
> > > 
> > > Would something like the below patch be accepted?  It makes my system
> > > work...
> > 
> > I already got a patch to remove the complete e820 validation code because
> > it broke far more than it fixed. That should fix your problem too.
> 
> Great!  Coming in 2.6.18?

Yes.

> 
> > > Also, why are we forcing 32 bit base addresses?  ACPI defines it to be a
> > > 64 bit base...
> > 
> > Where do you think we do that?
> 
> Looking at 2.6.17, we always have u32 base_address and u32
> base_reserved.  base_address is the only one ever referenced, that I can
> see.  I guess I should grab 2.6.18 pre-releases and recheck.

True. Please submit a patch.

-Andi
