Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261460AbULFCly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261460AbULFCly (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 21:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbULFCly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 21:41:54 -0500
Received: from HELIOUS.MIT.EDU ([18.238.1.151]:32675 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S261460AbULFClw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 21:41:52 -0500
Date: Sun, 5 Dec 2004 21:42:19 -0500
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Matthieu Castet <castet.matthieu@free.fr>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.9+] PnPBIOS: Missing SMALL_TAG_ENDDEP tag
Message-ID: <20041206024218.GD3103@neo.rr.com>
Mail-Followup-To: ambx1@neo.rr.com,
	Rene Herman <rene.herman@keyaccess.nl>,
	Matthieu Castet <castet.matthieu@free.fr>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <41B3A963.4090003@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B3A963.4090003@keyaccess.nl>
User-Agent: Mutt/1.5.6+20040722i
From: ambx1@neo.rr.com (Adam Belay)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2004 at 01:35:47AM +0100, Rene Herman wrote:
> Hi Adam.
> 
> Between 2.6.8 and 2.6.9, the following patch to rsparser.c was merged:
> 
> http://linus.bkbits.net:8080/linux-2.5/cset@414703f7MEe33PTYY-aFQaM3CLKjZw?nav=index.html|src/|src/drivers|src/drivers/pnp|src/drivers/pnp/pnpbios|related/drivers/pnp/pnpbios/rsparser.c
> 
> The added warning triggers on my machine:
> 
> Linux Plug and Play Support v0.97 (c) Adam Belay
> PnPBIOS: Scanning system for PnP BIOS support...
> PnPBIOS: Found PnP BIOS installation structure at 0xc00f7740
> PnPBIOS: PnP BIOS version 1.0, entry 0xf0000:0x6634, dseg 0xf0000
> PnPBIOS: Missing SMALL_TAG_ENDDEP tag
> PnPBIOS: Missing SMALL_TAG_ENDDEP tag
> PnPBIOS: Missing SMALL_TAG_ENDDEP tag
> PnPBIOS: Missing SMALL_TAG_ENDDEP tag
> PnPBIOS: 13 nodes reported by PnP BIOS; 13 recorded by driver
> 
> I don't believe those warnings should be printed, what with "broken" the 
> expected state of anything coming from the BIOS. The attached patch 
> removes them again. Works for me...
> 
> Rene.

Hi Rene,

Could you please send me "pnp.tar" from something like this:

mkdir /tmp/pnp; cp /proc/bus/pnp/[0-f][0-f] /tmp/pnp; tar -cf pnp.tar /tmp/pnp; rm -fR /tmp/pnp

make sure the pnpbios /proc interface is compiled into the kernel.

I'd like to look at the node data to see what's going on.

Thanks,
Adam
