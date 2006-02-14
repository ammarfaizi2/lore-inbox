Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422701AbWBNVJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422701AbWBNVJv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 16:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422707AbWBNVJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 16:09:51 -0500
Received: from [194.90.237.34] ([194.90.237.34]:18581 "EHLO mtlexch01.mtl.com")
	by vger.kernel.org with ESMTP id S1422701AbWBNVJu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 16:09:50 -0500
Date: Tue, 14 Feb 2006 23:11:11 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Roland Dreier <rdreier@cisco.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: AMD 8131 and MSI quirk
Message-ID: <20060214211111.GB14113@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <524q799p2t.fsf@cisco.com> <20060214165222.GC12974@mellanox.co.il> <adaslqlu76f.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adaslqlu76f.fsf@cisco.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 14 Feb 2006 21:11:38.0640 (UTC) FILETIME=[3E9EC900:01C631AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Roland Dreier <rdreier@cisco.com>:
> Subject: Re: AMD 8131 and MSI quirk
> 
> Michael, now I'm not sure whether this will work for devices like the
> Mellanox PCI-X HCA, where the HCA device sits below a virtual PCI
> bridge.  In that case we need to propagate the NO_MSI flag from the
> 8131 bridge to the Tavor bridge, right?

Yes, I tested on that system.

> And it has to work for
> systems like Sun V40Z where the PCI-X slots are hot-swappable (so the
> HCA and its bridge could be added later).

I expect it will work on hot swappable systems too: bus_flags are inherited
from parent to child bus.

-- 
Michael S. Tsirkin
Staff Engineer, Mellanox Technologies
