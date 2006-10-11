Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030786AbWJKDtW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030786AbWJKDtW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 23:49:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030783AbWJKDtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 23:49:22 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:60019 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1030782AbWJKDtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 23:49:21 -0400
X-IronPort-AV: i="4.09,292,1157353200"; 
   d="scan'208"; a="330283791:sNHT51698024"
To: David Miller <davem@davemloft.net>
Cc: mst@mellanox.co.il, shemminger@osdl.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, openib-general@openib.org, rolandd@cisco.com
Subject: Re: Dropping NETIF_F_SG since no checksum feature.
X-Message-Flag: Warning: May contain useful information
References: <adar6xfbk6d.fsf@cisco.com>
	<20061010.203624.91207079.davem@davemloft.net>
	<adak637bjs3.fsf@cisco.com>
	<20061010.204528.90823856.davem@davemloft.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 10 Oct 2006 20:49:09 -0700
In-Reply-To: <20061010.204528.90823856.davem@davemloft.net> (David Miller's message of "Tue, 10 Oct 2006 20:45:28 -0700 (PDT)")
Message-ID: <adafydvbjgq.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 11 Oct 2006 03:49:11.0603 (UTC) FILETIME=[36689830:01C6ECE8]
Authentication-Results: sj-dkim-8.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> non-sendfile() paths will generate big packets just fine,
    David> as long as the application is providing that much data.

OK, cool.  Will the big packets be non-linear skbs?

Because then it would make sense for a device with a huge MTU to want
to accept them without linearizing them, even if it had to copy them
to checksum the data.  Otherwise with fragmented memory it would be
impossible to handle such big packets at all.

 - R.
