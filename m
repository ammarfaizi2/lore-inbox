Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268750AbUJKJ7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268750AbUJKJ7V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 05:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268745AbUJKJ7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 05:59:21 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:20939 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S268750AbUJKJ7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 05:59:13 -0400
Date: Mon, 11 Oct 2004 11:57:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, David Brownell <david-b@pacbell.net>
Subject: Re: Totally broken PCI PM calls
Message-ID: <20041011095702.GB14530@atrey.karlin.mff.cuni.cz>
References: <1097455528.25489.9.camel@gaston> <Pine.LNX.4.58.0410101937100.3897@ppc970.osdl.org> <16746.299.189583.506818@cargo.ozlabs.ibm.com> <Pine.LNX.4.58.0410102102140.3897@ppc970.osdl.org> <16746.2820.352047.970214@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16746.2820.352047.970214@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> For now (i.e. 2.6.9), could we have the following patch?  It only
> affects suspend-to-disk, and it tells the drivers that we are going to
> D3cold (4) when we are doing suspend-to-disk.

If you want stop-gap solution, patch that was in -mm is better
idea. Please do *not* apply this one.

									Pavel

> --- linux-2.5/drivers/pci/pci-driver.c	2004-10-04 13:31:01.000000000 +1000
> +++ pmac-2.5/drivers/pci/pci-driver.c	2004-10-11 14:15:27.986286792 +1000
> @@ -307,7 +307,7 @@
>  		[PM_SUSPEND_ON] = 0,
>  		[PM_SUSPEND_STANDBY] = 1,
>  		[PM_SUSPEND_MEM] = 3,
> -		[PM_SUSPEND_DISK] = 3,
> +		[PM_SUSPEND_DISK] = 4,
>  	};
>  
>  	if (state >= sizeof(state_conversion) / sizeof(state_conversion[1]))

-- 
Boycott Kodak -- for their patent abuse against Java.
