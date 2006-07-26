Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWGZK2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWGZK2l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 06:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbWGZK2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 06:28:41 -0400
Received: from mxl145v65.mxlogic.net ([208.65.145.65]:49086 "EHLO
	p02c11o142.mxlogic.net") by vger.kernel.org with ESMTP
	id S932081AbWGZK2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 06:28:40 -0400
Date: Wed, 26 Jul 2006 13:29:44 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
       Roland Dreier <rolandd@cisco.com>, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: restore missing PCI registers after reset
Message-ID: <20060726102944.GA9411@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20060717162531.GC4829@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060717162531.GC4829@kroah.com>
User-Agent: Mutt/1.4.2.1i
X-OriginalArrivalTime: 26 Jul 2006 10:34:06.0265 (UTC) FILETIME=[05591290:01C6B09F]
X-Spam: [F=0.0100000000; S=0.010(2006062901)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting r. Greg KH <gregkh@suse.de>:
> Subject: [patch 02/45] IB/mthca: restore missing PCI registers after reset
> ------------------
> mthca does not restore the following PCI-X/PCI Express registers after reset:
>   PCI-X device: PCI-X command register
>   PCI-X bridge: upstream and downstream split transaction registers
>   PCI Express : PCI Express device control and link control registers
> 
> This causes instability and/or bad performance on systems where one of
> these registers is set to a non-default value by BIOS.
> 
> Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

By the way, Greg, this code is completely generic, and the same seems to apply
to all PCI-X/PCI-Express devices - should not pci_restore_state and
friends really know about these registers, as well?

What do you think?

-- 
MST
