Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262530AbULDF3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262530AbULDF3c (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 00:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262531AbULDF3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 00:29:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18376 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262530AbULDF31
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 00:29:27 -0500
Date: Fri, 3 Dec 2004 21:23:51 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: rf@q-leap.de, linux-kernel@vger.kernel.org
Subject: Re: Trouble with swiotlb
Message-ID: <20041203232351.GB3289@dmt.cyclades>
References: <16816.30598.368287.762457@gargle.gargle.HOWL> <41B0DC46.7050906@osdl.org> <16817.739.384632.576205@gargle.gargle.HOWL> <41B0FFD5.40401@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41B0FFD5.40401@osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2004 at 04:07:49PM -0800, Randy.Dunlap wrote:
> Roland Fehrenbacher wrote:
> >>>>>>"Randy" == Randy Dunlap <Randy.Dunlap> writes:
> >
> >
> >    Randy> Roland Fehrenbacher wrote:
> >    >> Hi,
> >    >> 
> >    >> when building 2.4.28 or 2.4.27 on x86_64 with IOMMU and SWIOTLB
> >    >> support enabled I get unresolved symbol for 3 modules:
> >    >> 
> >    >> depmod: *** Unresolved symbols in
> >    >> /lib/modules/2.4.28/kernel/drivers/net/e1000/e1000.o depmod:
> >    >> *** Unresolved symbols in
> >    >> /lib/modules/2.4.28/kernel/drivers/usb/host/uhci.o depmod: ***
> >    >> Unresolved symbols in
> >    >> /lib/modules/2.4.28/kernel/drivers/usb/host/usb-uhci.o
> >    >> 
> >    >> When modprobing any of the modules I get: unresolved symbol
> >    >> swiotlb
> >    >> 
> >    >> The kernel boots fine on Opterons and EM64T Xeons otherwise.
> >    >> 
> >    >> Any ideas.
> >
> >    Randy> Looks like it just needs 'swiotlb' exported (as in 2.6.x).
> >    Randy> Can you test the attached patch?  I don't have 2.4.x
> >    Randy> booting on x8-64 yet.
> >
> >Hi Randy,
> >
> >thanks for the fast reply. Your patch solved the problem. I can boot
> >Opterons and EM64T Xeons now without any problems.
> 
> Thanks for the results.  Marcelo, can you rip out my garbaged patch
> header/description before applying it?   :)

Done - thanks Randy.
