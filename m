Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263208AbTDRQRa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 12:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbTDRQQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 12:16:48 -0400
Received: from isis.cs3-inc.com ([207.224.119.73]:50683 "EHLO isis.cs3-inc.com")
	by vger.kernel.org with ESMTP id S263201AbTDRQQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 12:16:05 -0400
From: don-linux@isis.cs3-inc.com (Don Cohen)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16032.9818.987823.826601@isis.cs3-inc.com>
Date: Fri, 18 Apr 2003 09:22:50 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: proposed optimization for network drivers
In-Reply-To: <20030418.085933.131914868.davem@redhat.com>
References: <200304170656.h3H6ujA28940@isis.cs3-inc.com>
	<20030418.013640.28803567.davem@redhat.com>
	<16032.7069.454420.811252@isis.cs3-inc.com>
	<20030418.085933.131914868.davem@redhat.com>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:
 >    From: don-linux@isis.cs3-inc.com (Don Cohen)
 >    Date: Fri, 18 Apr 2003 08:37:01 -0700
 > 
 >    For instance, why does every driver have to call
 >    eth_type_trans?  Could that be delayed for netif_rx ?
 > 
 > Silly example.  Ethernet specific routines do not belong in
 > device generic netif_rx().

Ok, fair enough.
How about the larger point that it's reasonable to check early whether
the labor you're about to expend will be wasted and the suggestion
that this be encapsulated in a function that all drivers can share?

