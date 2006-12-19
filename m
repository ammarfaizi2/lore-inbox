Return-Path: <linux-kernel-owner+w=401wt.eu-S1752878AbWLSPob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878AbWLSPob (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 10:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753030AbWLSPob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 10:44:31 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:43941 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752878AbWLSPoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 10:44:30 -0500
Date: Tue, 19 Dec 2006 16:43:36 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Michael Tokarev <mjt@tls.msk.ru>
cc: Wiebe Cazemier <halfgaar@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: Software RAID1 (with non-identical discs) performance
In-Reply-To: <4587F113.2000804@tls.msk.ru>
Message-ID: <Pine.LNX.4.61.0612191641570.10396@yvahk01.tjqt.qr>
References: <em0pdq$r7o$2@sea.gmane.org> <em8lim$lqd$1@sea.gmane.org>
 <4587F113.2000804@tls.msk.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Think of "PnP geometry" supported by all nowadays drives.
>
>It's 255 heads, 63 sectors per track, and whatever number of cylinders.

You do not really need the 255-63-X PNP mode. Given a hard disk small
enough, VMware may make it a 16-63-X, 16-64-X, or something like
that. Still works as intended.

You see, the kernel mostly gives a damn about CHS, since the moment
the partition table is scanned, it is translated into LBA offsets (
part of that should be seen in /proc/partitions).


	-`J'
-- 
