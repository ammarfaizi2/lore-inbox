Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262109AbVCWWlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbVCWWlx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 17:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbVCWWlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 17:41:52 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:60339 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262109AbVCWWjd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 17:39:33 -0500
Date: Wed, 23 Mar 2005 23:39:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Len Brown <len.brown@intel.com>, LKML <linux-kernel@vger.kernel.org>,
       Shaohua Li <shaohua.li@intel.com>
Subject: Re: 2.6.12-rc1-mm1: resume regression [update] (was: Re: 2.6.12-rc1-mm1: Kernel BUG at pci:389)
Message-ID: <20050323223918.GL30704@elf.ucw.cz>
References: <20050322013535.GA1421@elf.ucw.cz> <20050322110126.GB1780@elf.ucw.cz> <200503222249.54091.rjw@sisk.pl> <200503232329.50461.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503232329.50461.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > Will this do it for the moment?
> > > 
> > > Its certainly better.
> > 
> > With the Len's patch applied I have to unload the modules:
> > 
> > ohci_hcd
> > ehci_hcd
> > yenta_socket
> > 
> > before suspend as each of them hangs the box solid during either
> > suspend or resume.  Moreover, when I tried to load the ehci_hcd
> > module back after resume, it hanged the box solid too.
> 
> This behavior is apparently caused by the call to pci_write_config_word() with
> pmcsr = 0 in drivers/pci/pci.c:pci_set_power_state().
> 
> Well, I don't think I can do anything more about it myself. :-)

Can you just revert those two patches from Len, and see what happens?

								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
