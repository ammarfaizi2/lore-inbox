Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261260AbUBWH2g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 02:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbUBWH2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 02:28:36 -0500
Received: from fmr04.intel.com ([143.183.121.6]:63403 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S261260AbUBWH2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 02:28:34 -0500
Subject: Re: 2.6.3-mm1 and aic7xxx
From: Len Brown <len.brown@intel.com>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615F2BAD@hdsmsx402.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F2BAD@hdsmsx402.hd.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1077521296.12675.81.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 23 Feb 2004 02:28:17 -0500
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-02-20 at 19:53, Fabio Coatti wrote:
> Alle 01:21, venerdì 20 febbraio 2004, Andrew Morton ha scritto:
> 
> > > I've also noticed (only with 2.6.3-mm1) a "PCI BIOS passed non
> existent
> > > PCI BUS 0!" message when it probes ICH5, i.e.
> >
> > Could be an acpi thing.  If you have time, could you try
> >
> >       patch -p1 -R < bk-acpi.patch
> >
> > and see if that helps?
> 
> Tried, the error message is disappeared (but my kernel still hangs on
> scsi 
> detection, so I'm unable if this has other effects :) )

Fabio,
Any chance you can isolate further where this broke by finding the
latest release where it worked properly?

ie. does vanilla 2.6.3 work if you back out the mm patch?

If 2.6.3 works, then I'd be interested if the following 2.6.3 patch
breaks it:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.3/acpi-20040116-2.6.3.diff.gz

If 2.6.3 fails, does 2.6.2 work?
If 2.6.2 works, I'd be interested if either of the following break it:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.2/acpi-20040211-2.6.2.diff.bz2
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.6.2/acpi-20040116-2.6.2.diff.gz

This will tell us if the most recent ACPI changes are causing this
failure, or if it is something else.

thanks,
-Len

ps, note that you can recover the original source tree by using patch -R
on the patch that you applied.


