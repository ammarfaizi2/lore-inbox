Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992439AbWJTCt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992439AbWJTCt4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 22:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992441AbWJTCt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 22:49:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:39075 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S2992436AbWJTCtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 22:49:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=uA3jp1nPj7Q4o8Ak28I+yFTSslr/mAn24szhVDc69N6lXtP1fhQpxOxVFBhQ3ekS+6QaADelaQscAO2xLQdqRXS/ZCBC4YuUuJ0rJkC09zLVUXGopG2curneskAF5E72mRCy2wGKTU4847NIhMSi91Bwj9x0zIWB7A43iQggXt0=
Date: Fri, 20 Oct 2006 11:50:45 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>, Paul Mackerras <paulus@samba.org>,
       Mirko Lindner <mlindner@syskonnect.de>,
       Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 4/6] net: use bitrev8
Message-ID: <20061020025045.GB6344@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Mirko Lindner <mlindner@syskonnect.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <20061018164647.GD21820@localhost> <20061019133951.1d463173.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061019133951.1d463173.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 01:39:51PM -0700, Andrew Morton wrote:

> A bunch of drivers.
> 
> > ===================================================================
> > --- work-fault-inject.orig/drivers/net/Kconfig
> > +++ work-fault-inject/drivers/net/Kconfig
> > @@ -2500,6 +2500,7 @@ config DEFXX
> >  config SKFP
> >  	tristate "SysKonnect FDDI PCI support"
> >  	depends on FDDI && PCI
> > +	select BITREVERSE
> >  	---help---
> >  	  Say Y here if you have a SysKonnect FDDI PCI adapter.
> >  	  The following adapters are supported by this driver:
> 
> But only one of them selects the library.

Other drivers already select CRC32 and CRC32 selects BITREVERSE.

> But select is problematic and I do wonder whether it'd be simpler to just
> link the thing into vmlinux.

OK. I'll try.

