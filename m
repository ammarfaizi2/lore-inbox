Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWERQRq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWERQRq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 12:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWERQRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 12:17:46 -0400
Received: from mail.kroah.org ([69.55.234.183]:30185 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751371AbWERQRp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 12:17:45 -0400
Date: Thu, 18 May 2006 08:54:41 -0700
From: Greg KH <gregkh@suse.de>
To: Brice Goglin <brice@myri.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: AMD 8131 MSI quirk called too late, bus_flags not inherited ?
Message-ID: <20060518155441.GB13334@suse.de>
References: <4468EE85.4000500@myri.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4468EE85.4000500@myri.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 11:11:33PM +0200, Brice Goglin wrote:
> Hi Greg,
> 
> While looking at the MSI detection, I noticed that the AMD 8131 quirk
> (quirk_amd_8131_ioapic) is defined as FINAL and thus executed after the
> PCI hierarchy is scanned. So it looks like the bus_flags won't be
> inherited at all. If there's a bridge behind the 8131, then the devices
> behind this bridge won't see the bus flags and thus might try to enable
> MSI anyway.
> I tried to change the AMD 8131 quirk to HEADER so that it is executed
> during PCI scanning. But, I don't get its message in dmesg anymore. Any
> idea?

Michael is the one who added that change, perhaps he can explain how he
tested it?

thanks,

greg k-h
