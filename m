Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbUCFMmr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Mar 2004 07:42:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbUCFMmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Mar 2004 07:42:47 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:13226 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261637AbUCFMmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Mar 2004 07:42:46 -0500
Date: Thu, 4 Mar 2004 16:08:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       James Morris <jmorris@redhat.com>,
       Christophe Saout <christophe@saout.de>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: dm-crypt, new IV and standards
Message-ID: <20040304150836.GE531@openzaurus.ucw.cz>
References: <20040220172237.GA9918@certainkey.com> <Xine.LNX.4.44.0402201624030.7335-100000@thoron.boston.redhat.com> <20040221164821.GA14723@certainkey.com> <Pine.LNX.4.58.0403022352080.12846@twinlark.arctic.org> <20040303150647.GC1586@certainkey.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040303150647.GC1586@certainkey.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Well, CTR mode is not recommended for encrypted file systems because it is very
> > > easy to corrupt single bits, bytes, blocks, etc without an integrity check.
> > > If we add a MAC, then any mode of operation except ECB can be used for
> > > encrypted file systems.
> > 
> > what does "easy to corrupt" mean?  i haven't really seen disks generate
> > bit errors ever.  this MAC means you'll need to write integrity data for
> > every real write.  that really doesn't seem worth it...
> 
> The difference between "_1,000,000" and "_8,000,000" is 1 bit.  If an
> attacker knew enough about the layout of the filesystem (modify times on blocks,
> etc) they could flip a single bit and change your _1Mil purchase order
> approved by your boss to a _8Mil order.

Hmm... long time ago I created crc loop device to catch
faulty disks. If cryptoloop can do that for me... very good!
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

