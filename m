Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263508AbTHVScd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 14:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263447AbTHVScc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 14:32:32 -0400
Received: from acsrs1.bu.edu ([128.197.153.59]:15000 "EHLO acsrs1.bu.edu")
	by vger.kernel.org with ESMTP id S263508AbTHVScb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 14:32:31 -0400
Date: Fri, 22 Aug 2003 14:32:18 -0400 (EDT)
From: Parmer <gabep1@bu.edu>
To: Ben Greear <greearb@candelatech.com>
cc: Patrick Sodre Carlos <klist@i-a-i.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Reinjecting IP Packets
In-Reply-To: <3F464177.1020709@candelatech.com>
Message-ID: <Pine.A41.4.53.0308221429420.174462@acsrs1.bu.edu>
References: <1061563295.824.4.camel@iai68> <3F464177.1020709@candelatech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Aug 2003, Ben Greear wrote:

> Patrick Sodre Carlos wrote:
> > Hi Guys,
> >    I'm trying to figure out what is the best way to reinject IP packets
> > into the stack. Does anyone have good/right/left ideas on this?
>
> Maybe netif_rx() in net/core/dev.c ?

If you want an example of how this is done, look in /net/ipv4/ipip.c and
(I'm pretty sure) /net/ipv4/ip_gre.c.  I only know 2.4.*, but the files
still exist in 2.6, and they probably do it the same way.

Fairly elegant way to strip some headers and send it though again.

Hope that helps,
Gabe
