Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264508AbTLQShv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 13:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264511AbTLQShv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 13:37:51 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:15536 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S264508AbTLQShu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 13:37:50 -0500
Date: Wed, 17 Dec 2003 10:37:39 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Peter Zaitsev <peter@mysql.com>, Helge Hafting <helgehaf@aitel.hist.no>,
       jw schultz <jw@pegasys.ws>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: raid0 slower than devices it is assembled of?
Message-ID: <20031217183739.GG1402@matchmail.com>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Peter Zaitsev <peter@mysql.com>,
	Helge Hafting <helgehaf@aitel.hist.no>, jw schultz <jw@pegasys.ws>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200312151434.54886.adasi@kernel.pl> <20031216040156.GJ12726@pegasys.ws> <3FDF1C03.2020509@aitel.hist.no> <Pine.LNX.4.58.0312160825570.1599@home.osdl.org> <20031216205853.GC1402@matchmail.com> <Pine.LNX.4.58.0312161304390.1599@home.osdl.org> <1071657159.2155.76.camel@abyss.local> <Pine.LNX.4.58.0312170758220.8541@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312170758220.8541@home.osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 17, 2003 at 08:01:13AM -0800, Linus Torvalds wrote:
> However, since seeking will be limited by the checksum drive anyway (for 
> writing), the advantages of large stripes in trying to keep the disks 
> independent aren't as one-sided. 

It seems to me that you are referring to a single pairity drive in the
array.  That is raid4, where only one drive handles the pairity data for the
entire array regardless of array size.

Raid5 staggers the pairidy data (md has four different staggering layouts)
so that the data, and pairity are on two different drives, and that varies
based on stripe and layout.
