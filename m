Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262608AbVA0NEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbVA0NEY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 08:04:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262609AbVA0NEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 08:04:23 -0500
Received: from mx1.slu.se ([130.238.96.70]:43415 "EHLO mx1.slu.se")
	by vger.kernel.org with ESMTP id S262608AbVA0NEB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 08:04:01 -0500
From: Robert Olsson <Robert.Olsson@data.slu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16888.59047.957865.592152@robur.slu.se>
Date: Thu, 27 Jan 2005 14:03:35 +0100
To: Robert Olsson <Robert.Olsson@data.slu.se>
Cc: Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       torvalds@osdl.org, alexn@dsv.su.se, kas@fi.muni.cz,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Memory leak in 2.6.11-rc1?
In-Reply-To: <16888.58622.376497.380197@robur.slu.se>
References: <20050121161959.GO3922@fi.muni.cz>
	<1106360639.15804.1.camel@boxen>
	<20050123091154.GC16648@suse.de>
	<20050123011918.295db8e8.akpm@osdl.org>
	<20050123095608.GD16648@suse.de>
	<20050123023248.263daca9.akpm@osdl.org>
	<20050123200315.A25351@flint.arm.linux.org.uk>
	<20050124114853.A16971@flint.arm.linux.org.uk>
	<20050125193207.B30094@flint.arm.linux.org.uk>
	<20050127082809.A20510@flint.arm.linux.org.uk>
	<20050127004732.5d8e3f62.akpm@osdl.org>
	<16888.58622.376497.380197@robur.slu.se>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oh. Linux version 2.6.11-rc2 was used.

Robert Olsson writes:
 > 
 > Andrew Morton writes:
 >  > Russell King <rmk+lkml@arm.linux.org.uk> wrote:
 > 
 >  > >  ip_dst_cache        1292   1485    256   15    1
 > 
 >  > I guess we should find a way to make it happen faster.
 >  
 > Here is route DoS attack. Pure routing no NAT no filter.
 > 
 > Start
 > =====
 > ip_dst_cache           5     30    256   15    1 : tunables  120   60    8 : slabdata      2      2      0
 > 
 > After DoS
 > =========
 > ip_dst_cache       66045  76125    256   15    1 : tunables  120   60    8 : slabdata   5075   5075    480
 > 
 > After some GC runs.
 > ==================
 > ip_dst_cache           2     15    256   15    1 : tunables  120   60    8 : slabdata      1      1      0
 > 
 > No problems here. I saw Martin talked about NAT...
 > 
 > 							--ro
