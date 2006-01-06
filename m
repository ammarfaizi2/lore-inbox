Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbWAFJDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbWAFJDL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 04:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWAFJDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 04:03:10 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8865 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932363AbWAFJDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 04:03:08 -0500
Date: Fri, 6 Jan 2006 10:00:52 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [linux-pm] [patch] pm: fix runtime powermanagement's /sys interface
Message-ID: <20060106090052.GJ3339@elf.ucw.cz>
References: <20060105215528.GF2095@elf.ucw.cz> <20060105221334.GA925@isilmar.linta.de> <20060105222338.GG2095@elf.ucw.cz> <20060105222705.GA12242@isilmar.linta.de> <20060105230849.GN2095@elf.ucw.cz> <20060105234629.GA7298@isilmar.linta.de> <20060105235838.GC3339@elf.ucw.cz> <Pine.LNX.4.50.0601051602560.10428-100000@monsoon.he.net> <20060106001252.GE3339@elf.ucw.cz> <Pine.LNX.4.50.0601051729400.30092-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0601051729400.30092-100000@monsoon.he.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One more nit...

> +	s += sprintf(s, "d0");
> +	if (dev->poss_states[PCI_D1])
> +		s += sprintf(s, " d1");
> +	if (dev->poss_states[PCI_D2])
> +		s += sprintf(s, " d2");
> +	if (dev->poss_states[PCI_D3hot])
> +		s += sprintf(s, " d3");
...
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -106,6 +106,7 @@ struct pci_dev {
>  					   this if your device has broken DMA
>  					   or supports 64-bit transfers.  */
> 
> +	u32		poss_states[4];

So this probably should be poss_states[PCI_D3hot]; or something,
instead of explicit "4".
							Pavel

-- 
Thanks, Sharp!
