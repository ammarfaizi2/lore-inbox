Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422699AbWJLCEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422699AbWJLCEO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 22:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422700AbWJLCEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 22:04:14 -0400
Received: from mx2.netapp.com ([216.240.18.37]:12608 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1422699AbWJLCEN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 22:04:13 -0400
X-IronPort-AV: i="4.09,297,1157353200"; 
   d="scan'208"; a="417205481:sNHT18484836"
Subject: Re: [patch 03/19] SUNRPC: avoid choosing an IPMI port for RPC
	traffic
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20061012015306.GB27693@lists.us.dell.com>
References: <20061010165621.394703368@quad.kroah.org>
	 <20061010171429.GD6339@kroah.com>
	 <Pine.LNX.4.61.0610102056290.17718@yvahk01.tjqt.qr>
	 <1160610353.7015.8.camel@lade.trondhjem.org>
	 <1160615547.20611.0.camel@localhost.localdomain>
	 <1160616905.6596.14.camel@lade.trondhjem.org>
	 <20061012015306.GB27693@lists.us.dell.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Wed, 11 Oct 2006 19:04:02 -0700
Message-Id: <1160618642.6596.27.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 12 Oct 2006 02:04:03.0498 (UTC) FILETIME=[B0E5E8A0:01C6EDA2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-11 at 20:53 -0500, Matt Domsch wrote:
> My hackish solution was to create a fake xinetd service listening on
> those ports.
> 
> http://lists.us.dell.com/pipermail/linux-poweredge/2005-November/023606.html
> 
> For the one Dell server affected, we could DMI list
> it; likewise for others.

Right, but that requires prior knowledge that the board in question is
afflicted. Several people that were affected by the bug were unaware of
the motherboard behaviour.
The daemon solution also fails to provide any guarantees on a NFSROOT
setup.

In any case, as I said, these are just defaults which may be overridden
by the user at runtime.

Cheers,
  Trond
