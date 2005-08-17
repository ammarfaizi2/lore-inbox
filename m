Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbVHRKrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbVHRKrU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 06:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbVHRKrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 06:47:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57785 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932173AbVHRKrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 06:47:19 -0400
Date: Wed, 17 Aug 2005 16:35:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: =?iso-8859-2?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Flash erase groups and filesystems
Message-ID: <20050817143534.GC516@openzaurus.ucw.cz>
References: <4300F963.5040905@drzeus.cx> <20050816162735.GB21462@wohnheim.fh-wedel.de> <43021DB8.70909@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43021DB8.70909@drzeus.cx>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Question came up before, albeit with a different phrasing.  One
> >possible approach to benefit from this ability would be to create a
> >"forget" operation.  When a filesystem already knows that some data is
> >unneeded (after a truncate or erase operation), it will ask the device
> >to forget previously occupied blocks.
> >
> >The device then has the _option_ of handling the forget operation.
> >Further reads on these blocks may return random data.
> >
> >And since noone stepped up to implement this yet, you can still get
> >all the fame and glory yourself! ;)
> >  
> >
> 
> I'm not sure we're talking about the same thing. I'm not suggesting new
> features in the VFS layer. I want to know if something breaks if I
> implement this erase feature in the MMC layer. In essence the file
> system has marked the sectors as "forget" by issuing a write to them.
> The question is if it is assumed that they are unchanged if the write
> fails half-way through.

Journaling filesystems may not like finding 0xff's all over their journal...
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

