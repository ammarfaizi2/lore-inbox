Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161263AbWJKXqG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161263AbWJKXqG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 19:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161281AbWJKXqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 19:46:06 -0400
Received: from mx2.netapp.com ([216.240.18.37]:59728 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1161263AbWJKXqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 19:46:03 -0400
X-IronPort-AV: i="4.09,296,1157353200"; 
   d="scan'208"; a="417174025:sNHT78614988"
Subject: Re: [patch 03/19] SUNRPC: avoid choosing an IPMI port for RPC
	traffic
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <Pine.LNX.4.61.0610102056290.17718@yvahk01.tjqt.qr>
References: <20061010165621.394703368@quad.kroah.org>
	 <20061010171429.GD6339@kroah.com>
	 <Pine.LNX.4.61.0610102056290.17718@yvahk01.tjqt.qr>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Wed, 11 Oct 2006 19:45:53 -0400
Message-Id: <1160610353.7015.8.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 11 Oct 2006 23:46:13.0582 (UTC) FILETIME=[6FA4DEE0:01C6ED8F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 20:59 +0200, Jan Engelhardt wrote:
> >Some hardware uses port 664 for its hardware-based IPMI listener.  Teach
> >the RPC client to avoid using that port by raising the default minimum port
> >number to 665.
> 
> Eh, that does look more like a quick hack. What if there were enough
> manufacturers around to use various parts, like manuf. A using 664, B using 800
> and C using 1000? Then the port range would have to be cut down again and
> again.
> 
> 
> 	-`J'

Feel free to tell the board manufacturers that they are idiots, and
should not design boards that hijack specific ports without providing
the O/S with any means of detecting this, but in the meantime, it _is_
the case that they are doing this.

Cheers,
  Trond
