Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272165AbTHNFHE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 01:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272166AbTHNFHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 01:07:04 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:58853 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S272165AbTHNFHA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 01:07:00 -0400
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
From: Yury Umanets <umka@namesys.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Daniel Egger <degger@fhm.edu>, Hans Reiser <reiser@namesys.com>,
       Nikita Danilov <Nikita@namesys.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       reiserfs mailing list <reiserfs-list@namesys.com>
In-Reply-To: <Pine.LNX.3.96.1030813160910.12417A-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1030813160910.12417A-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Organization: NAMESYS
Message-Id: <1060837469.17622.6.camel@haron.namesys.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 14 Aug 2003 09:04:29 +0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-08-14 at 00:12, Bill Davidsen wrote:
> On Sun, 27 Jul 2003, Yury Umanets wrote:
> 
> > On Sun, 2003-07-27 at 18:10, Daniel Egger wrote:
> > > Am Son, 2003-07-27 um 15.28 schrieb Hans Reiser:
> 
> > > > or for which a wear leveling block device driver is used (I don't know
> > > > if one exists for Linux).
> > > 
> > > This is normally done by the filesystem (e.g. JFFS2).
> > 
> > Normally device driver should be concerned about making wear out
> > smaller. It is up to it IMHO.

> 
> The driver should do the logical to physical mapping, but the portability
> vanishes if the filesystem to physical mapping is not the same for all
> machines and operating systems. For pluggable devices this is important.
> 
> The leveling seems to be done by JFFs2 in a portable way, and that's as it
> should be. If the leveling were in the driver I don't believe even FAT
> would work.

Hello Bill,

Yes, you are right. Device driver cannot take care about leveling.

It is able only to take care about simple caching (one erase block) in 
order to make wear out smaller and do not read/write whole block if one 
sector should be written.

Part of a filesystem called "block allocator" should take care about 
leveling.

