Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751594AbWHZDFl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbWHZDFl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 23:05:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751588AbWHZDFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 23:05:41 -0400
Received: from helium.samage.net ([83.149.67.129]:7133 "EHLO helium.samage.net")
	by vger.kernel.org with ESMTP id S1751583AbWHZDFk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 23:05:40 -0400
Message-ID: <3317.81.207.0.53.1156561530.squirrel@81.207.0.53>
In-Reply-To: <1156538183.26945.15.camel@lappy>
References: <20060825153946.24271.42758.sendpatchset@twins> 
    <20060825154027.24271.43168.sendpatchset@twins> 
    <1156536880.5927.29.camel@localhost>
    <1156538183.26945.15.camel@lappy>
Date: Sat, 26 Aug 2006 05:05:30 +0200 (CEST)
Subject: Re: [PATCH 4/4] nfs: deadlock prevention for NFS
From: "Indan Zupancic" <indan@nul.nu>
To: "Peter Zijlstra" <a.p.zijlstra@chello.nl>
Cc: "Trond Myklebust" <trond.myklebust@fys.uio.no>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       "Evgeniy Polyakov" <johnpol@2ka.mipt.ru>,
       "Daniel Phillips" <phillips@google.com>,
       "Rik van Riel" <riel@redhat.com>, "David Miller" <davem@davemloft.net>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	/* Check if this were the first socks: */
> 	if (nr_socks - socks == 0)
> 		reserve += RX_RESERVE_PAGES;

Can of course be:

 	if (nr_socks == socks)
 		reserve += RX_RESERVE_PAGES;

Grumble,

Indan


