Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275707AbRI0AI5>; Wed, 26 Sep 2001 20:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275715AbRI0AIr>; Wed, 26 Sep 2001 20:08:47 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:28676
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S275707AbRI0AIa>; Wed, 26 Sep 2001 20:08:30 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200109262349.f8QNnju14536@www.hockin.org>
Subject: Re: Question: Etherenet Link Detection
To: rddunlap@osdlab.org (Randy.Dunlap)
Date: Wed, 26 Sep 2001 16:49:44 -0700 (PDT)
Cc: mdharm-kernel@one-eyed-alien.net (Matthew Dharm),
        peter@zaphod.nu (Peter Sandstrom), robert@tux.cs.ou.edu (Robert Cantu),
        linux-kernel@vger.kernel.org
In-Reply-To: <3BB26983.29B37F4E@osdlab.org> from "Randy.Dunlap" at Sep 26, 2001 04:49:23 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's traditionally been defined as MII information, but that's
> awfully slow, so some Ethernet controllers make it available
> in a quicker manner.
> 
> ethtool might do this (http://sourceforge.net/projects/gkernel/);
> I don't know for sure.

The only interface to this is through MII, unless we want to add an ETHTOOL
style ioctl to get the link status.  This means, however, that every driver
that wants to report this needs to support at least a subset of ethtool
ioctls, which VERY FEW do.

