Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932462AbWFSP1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932462AbWFSP1J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 11:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbWFSP1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 11:27:09 -0400
Received: from colo.lackof.org ([198.49.126.79]:31391 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S932462AbWFSP1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 11:27:08 -0400
Date: Mon, 19 Jun 2006 09:27:06 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Matthew Wilcox <matthew@wil.cx>, Brice Goglin <brice@myri.com>,
       linux-pci@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport capabilities
Message-ID: <20060619152706.GC7575@colo.lackof.org>
References: <4493709A.7050603@myri.com> <20060617050524.GX2387@parisc-linux.org> <1150715995.14284.10.camel@capoeira>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1150715995.14284.10.camel@capoeira>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 01:19:55PM +0200, Xavier Bestel wrote:
> On Sat, 2006-06-17 at 07:05, Matthew Wilcox wrote:
> > On Fri, Jun 16, 2006 at 11:01:46PM -0400, Brice Goglin wrote:
> > > We introduce whitelisting of chipsets that are known to support MSI and
> > > keep the existing backlisting to disable MSI for other chipsets. When it
> > > is unknown whether the root chipset support MSI or not, we disable MSI
> > > by default except if pci=forcemsi was passed.
> > 
> > I think that's a bad idea.  Blacklisting is the better idea in the long-term.
> 
> I think the option adopted elsewhere is: whitelist for old chipsets, and
> blacklist for new chipsets. You just have to decide for a good date to
> separate "old" and "new" to minimize the lists size.

I agree with willy.

White lists work "well" only if one's goal is to reduce the number
of bug reports about _all_ HW. Most folks with _working_ MSI (but not
already on the whitelist) won't know they could report this as a bug.
Ie these chipsets likely won't ever get added to the whitelist.

thanks,
grant
