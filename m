Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVFGC3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVFGC3U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 22:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVFGC3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 22:29:19 -0400
Received: from webmail.topspin.com ([12.162.17.3]:26808 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261438AbVFGC25 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 22:28:57 -0400
To: Greg KH <gregkh@suse.de>
Cc: Dave Jones <davej@redhat.com>, Grant Grundler <grundler@parisc-linux.org>,
       tom.l.nguyen@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: pci_enable_msi() for everyone?
X-Message-Flag: Warning: May contain useful information
References: <20050603224551.GA10014@kroah.com>
	<20050604013112.GB16999@colo.lackof.org>
	<20050604064821.GC13238@suse.de>
	<20050604070537.GB8230@colo.lackof.org>
	<20050604071803.GA13684@suse.de> <20050604072348.GA28293@redhat.com>
	<20050606230118.GD11184@suse.de>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 06 Jun 2005 17:26:32 -0700
In-Reply-To: <20050606230118.GD11184@suse.de> (Greg KH's message of "Mon, 6
 Jun 2005 16:01:18 -0700")
Message-ID: <5264wrj9l3.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 07 Jun 2005 02:28:53.0981 (UTC) FILETIME=[A60E90D0:01C56B08]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    davej> What if MSI support has been disabled in the bridge due to
    davej> some quirk (like the recent AMD 8111 quirk) ?  Maybe the
    davej> above function should check pci_msi_enable as well ?

    Greg> Yes, you are correct.  I said it wasn't tested :)

Huh?  If a host bridge doesn't support MSI, and a device below it has
its MSI capability enabled, we're in big trouble.  Because that device
is going to send interrupt messages whether the bridge likes it or
not.

 - R.
