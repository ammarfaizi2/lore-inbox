Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275386AbTHMUV0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 16:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275395AbTHMUV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 16:21:26 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:38407 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S275386AbTHMUVZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 16:21:25 -0400
Date: Wed, 13 Aug 2003 16:12:43 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Yury Umanets <umka@namesys.com>
cc: Daniel Egger <degger@fhm.edu>, Hans Reiser <reiser@namesys.com>,
       Nikita Danilov <Nikita@namesys.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       reiserfs mailing list <reiserfs-list@namesys.com>
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
In-Reply-To: <1059315305.25361.9.camel@haron.namesys.com>
Message-ID: <Pine.LNX.3.96.1030813160910.12417A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jul 2003, Yury Umanets wrote:

> On Sun, 2003-07-27 at 18:10, Daniel Egger wrote:
> > Am Son, 2003-07-27 um 15.28 schrieb Hans Reiser:

> > > or for which a wear leveling block device driver is used (I don't know
> > > if one exists for Linux).
> > 
> > This is normally done by the filesystem (e.g. JFFS2).
> 
> Normally device driver should be concerned about making wear out
> smaller. It is up to it IMHO.

The driver should do the logical to physical mapping, but the portability
vanishes if the filesystem to physical mapping is not the same for all
machines and operating systems. For pluggable devices this is important.

The leveling seems to be done by JFFs2 in a portable way, and that's as it
should be. If the leveling were in the driver I don't believe even FAT
would work.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

