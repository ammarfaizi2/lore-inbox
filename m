Return-Path: <linux-kernel-owner+w=401wt.eu-S932428AbXAPGrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932428AbXAPGrZ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 01:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbXAPGrZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 01:47:25 -0500
Received: from mx2.netapp.com ([216.240.18.37]:6767 "EHLO mx2.netapp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932428AbXAPGrY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 01:47:24 -0500
X-IronPort-AV: i="4.13,194,1167638400"; 
   d="scan'208"; a="21667823:sNHT44904433"
Subject: Re: Some kind of 2.6.19 NFS regression
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Daniel Drake <dsd@gentoo.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45AC0DB0.5020000@gentoo.org>
References: <45AC0DB0.5020000@gentoo.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Tue, 16 Jan 2007 01:47:22 -0500
Message-Id: <1168930042.6072.16.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 16 Jan 2007 06:47:23.0492 (UTC) FILETIME=[2D572240:01C7393A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2007-01-15 at 18:26 -0500, Daniel Drake wrote:
> Hi,
> 
> Tim Ryan has reported the following bug at the Gentoo bugzilla:
> 
> https://bugs.gentoo.org/show_bug.cgi?id=162199
> 
> His home dir is mounted over NFS. 2.6.18 worked OK but 2.6.19 is very 
> slow to load the desktop environment. NFS is suspected here as the 
> problem does not exist for users with local homedirs. This might not be 
> a straightforward performance issue as it does seem to perform OK on the 
> console.
> 
> The bug still exists in unpatched 2.6.20-rc5.
> 
> Is this a known issue? Should we report a new bug on the kernel bugzilla?
> 
> Thanks,
> Daniel

I couldn't find any information whatsoever in that bug report as to what
mount options he is using, or what server export options are in use. No
info either about what networking hardware he is using (or what drivers
are in use).

I'd also recommend using something like ttcp to see if large packets
(NFS read/write packets are typically ~ 32k large) are being transmitted
efficiently.

Cheers
  Trond
