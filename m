Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932526AbWJLPBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932526AbWJLPBo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 11:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbWJLPBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 11:01:44 -0400
Received: from mx2.netapp.com ([216.240.18.37]:15950 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S932526AbWJLPBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 11:01:43 -0400
X-IronPort-AV: i="4.09,301,1157353200"; 
   d="scan'208"; a="417383402:sNHT47749452"
Subject: Re: [patch 03/19] SUNRPC: avoid choosing an IPMI port for RPC
	traffic
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <Pine.LNX.4.61.0610120956000.17740@yvahk01.tjqt.qr>
References: <20061010165621.394703368@quad.kroah.org>
	 <20061010171429.GD6339@kroah.com>
	 <Pine.LNX.4.61.0610102056290.17718@yvahk01.tjqt.qr>
	 <1160610353.7015.8.camel@lade.trondhjem.org>
	 <1160615547.20611.0.camel@localhost.localdomain>
	 <1160616905.6596.14.camel@lade.trondhjem.org>
	 <Pine.LNX.4.61.0610120956000.17740@yvahk01.tjqt.qr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Thu, 12 Oct 2006 08:01:17 -0700
Message-Id: <1160665277.6004.27.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 12 Oct 2006 15:01:35.0263 (UTC) FILETIME=[4F8452F0:01C6EE0F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 09:58 +0200, Jan Engelhardt wrote:
> >Interestingly, Linux is not the only OS that has been hit by this
> >problem:
> >
> >  http://blogs.sun.com/shepler/entry/port_623_or_the_mount
> 
> There is more to it. On a machine I had set up a second,
> experimental, apache on port 880. And it randomly failed to start on
> a boot because mountd had taken the port first.
> Man, this RPC stuff should go and use fixed ports.

man 8 mountd and check out the '-p' option. statd has a similar one.
Even the in-kernel lockd daemon's can be set to listen to fixed ports.

So there really shouldn't be any problems nailing down your RPC ports.

Cheers,
  Trond
