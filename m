Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750945AbWC0QIy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750945AbWC0QIy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 11:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750915AbWC0QIy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 11:08:54 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:58758 "EHLO
	mail1.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S1750909AbWC0QIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 11:08:53 -0500
Date: Mon, 27 Mar 2006 11:08:45 -0500
From: "Bill Rugolsky Jr." <bill@rugolsky.com>
To: Matt Heler <lkml@lpbproductions.com>
Cc: Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH][INCOMPLETE] sata_nv: merge ADMA support
Message-ID: <20060327160845.GG9411@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <bill@rugolsky.com>,
	Matt Heler <lkml@lpbproductions.com>, Jeff Garzik <jeff@garzik.org>,
	linux-kernel@vger.kernel.org,
	"linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
References: <20060317232339.GA5674@ti64.telemetry-investments.com> <20060319232317.GA25578@ti64.telemetry-investments.com> <441F56AD.8020001@garzik.org> <200603262014.35466.lkml@lpbproductions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603262014.35466.lkml@lpbproductions.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2006 at 08:14:35PM -0500, Matt Heler wrote:
> Using Bill's original patch I was able to boot up perfectly with adma support 
> enabled on my workstation. Even after several stress tests ( 
> tar -cf /dev/null . , and dd if=/dev/sda of=/dev/null ), everything seems to 
> be a-ok. However when I tried the sata_nv.c file that you sent to Bill, I 
> kept on getting hardlocks, and thus was unable to stress test your version. 
> 
> Also for note, I heve not received any of the timeout problems reported by 
> Bill. Nor have I had any latency problems with adma enabled.
 
Matt,

Nice to see some value falling out of this sata_nv thread.  Did you see
latency problems before enabling ADMA?

Would you provide some specifics on your setup?

Which motherboard, #CPUs, BIOS revision, kernel, MD/LVM2/fs?

On two of my Tyan S2895 machines, including the one that I'm using for testing,
lspci says:

00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev f2)
00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3)
00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev f3)

and dmidecode says:

BIOS Information
        Vendor: Phoenix Technologies Ltd.
        Version: 2004Q3
        Release Date: 10/12/2005

The other, where I first had lost tick problems, says:

00:06.0 IDE interface: nVidia Corporation CK804 IDE (rev a2)
00:07.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev a3)
00:08.0 IDE interface: nVidia Corporation CK804 Serial ATA Controller (rev a3)

BIOS Information
	Vendor: Phoenix Technologies Ltd.
	Version: 2004Q3
	Release Date: 06/07/2005


Thanks,

	Bill
