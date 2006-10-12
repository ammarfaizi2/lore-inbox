Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751079AbWJLRQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079AbWJLRQo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 13:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750970AbWJLRQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 13:16:43 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:22502 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750968AbWJLRQm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 13:16:42 -0400
Date: Thu, 12 Oct 2006 12:16:37 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Jeremy Higdon <jeremy@sgi.com>,
       Pat Gefre <pfg@sgi.com>
Subject: Re: [PATCH 2/2] ioc4: Enable build on non-SN2
In-Reply-To: <20061011172332.8f7b354f.akpm@osdl.org>
Message-ID: <20061012121528.E85966@pkunk.americas.sgi.com>
References: <20061010120928.V71367@pkunk.americas.sgi.com>
 <20061011172332.8f7b354f.akpm@osdl.org>
Organization: Silicon Graphics, Inc.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My sincere apologies for this.

Would you prefer I send a corrected patch (the oversight was actually
in the previous patch in the series), or simply a new patch that
builds atop the other two and fixes the problem?

Thanks,
Brent

On Wed, 11 Oct 2006, Andrew Morton wrote:

> On Tue, 10 Oct 2006 12:11:16 -0500 (CDT)
> Brent Casavant <bcasavan@sgi.com> wrote:
> 
> > The SGI PCI-RT card, based on the SGI IOC4 chip, will be made available
> > on Altix XE (x86_64) platforms in the near future.  As such it is now a
> > misnomer for the IOC4 base device driver to live under drivers/sn, and
> > would complicate builds for non-SN2.
> > 
> > This patch moves the IOC4 base driver code from drivers/sn to drivers/misc,
> > and updates the associated Makefiles and Kconfig files to allow building
> > on non-SN2 configs.  Due to the resulting change in link order, it is now
> > necessary to use late_initcall() for IOC4 subdriver initialization.
> > 
> > ...
> >
> > +#include <asm/sn/addrs.h>
> > +#include <asm/sn/clksupport.h>
> > +#include <asm/sn/shub_mmr.h>
> 
> That doesn't work so good on x86.
> 

-- 
Brent Casavant                          All music is folk music.  I ain't
bcasavan@sgi.com                        never heard a horse sing a song.
Silicon Graphics, Inc.                    -- Louis Armstrong
