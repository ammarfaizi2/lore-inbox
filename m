Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422756AbWBNS14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422756AbWBNS14 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 13:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422760AbWBNS14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 13:27:56 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:19623 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1422756AbWBNS1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 13:27:55 -0500
X-IronPort-AV: i="4.02,114,1139212800"; 
   d="scan'208"; a="404963041:sNHT29769522"
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Roland Dreier <rolandd@cisco.com>, gregkh@suse.de,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: AMD 8131 and MSI quirk
X-Message-Flag: Warning: May contain useful information
References: <524q799p2t.fsf@cisco.com> <20060214165222.GC12974@mellanox.co.il>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 14 Feb 2006 10:27:52 -0800
In-Reply-To: <20060214165222.GC12974@mellanox.co.il> (Michael S. Tsirkin's
 message of "Tue, 14 Feb 2006 18:52:22 +0200")
Message-ID: <adaslqlu76f.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 14 Feb 2006 18:27:53.0736 (UTC) FILETIME=[5E856880:01C63194]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael, now I'm not sure whether this will work for devices like the
Mellanox PCI-X HCA, where the HCA device sits below a virtual PCI
bridge.  In that case we need to propagate the NO_MSI flag from the
8131 bridge to the Tavor bridge, right?  And it has to work for
systems like Sun V40Z where the PCI-X slots are hot-swappable (so the
HCA and its bridge could be added later).

 - R.
