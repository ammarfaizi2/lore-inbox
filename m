Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbUJaXQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbUJaXQa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 18:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbUJaXQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 18:16:30 -0500
Received: from inx.pm.waw.pl ([195.116.170.20]:37009 "EHLO inx.pm.waw.pl")
	by vger.kernel.org with ESMTP id S261688AbUJaXQN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 18:16:13 -0500
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, davem@davemloft.net,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: net: generic netdev_ioaddr
References: <1099044244.9566.0.camel@localhost>
	<20041029131607.GU24336@parcelfarce.linux.theplanet.co.uk>
	<courier.418290EC.00002E85@courier.cs.helsinki.fi>
	<m3y8hpbaf9.fsf@defiant.pm.waw.pl>
	<20041029193827.GV24336@parcelfarce.linux.theplanet.co.uk>
	<m3u0sdb53f.fsf@defiant.pm.waw.pl>
	<1099129946.10961.9.camel@localhost>
	<m3r7nfem2v.fsf@defiant.pm.waw.pl>
	<1099206669.9571.10.camel@localhost>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 01 Nov 2004 00:14:24 +0100
In-Reply-To: <1099206669.9571.10.camel@localhost> (Pekka Enberg's message of
 "Sun, 31 Oct 2004 09:11:09 +0200")
Message-ID: <m3wtx6jx9r.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Pekka Enberg <penberg@cs.helsinki.fi> writes:

> Cops already exposes base address and irq as module parameters and yet
> it calls netdev_boot_setup_check() to check "netdev=" so I assume
> there's a reason for that.  Perhaps something like the (untested) patch
> below would make more sense?

IMHO partially: base_addr etc should go from the core (to driver's
local structs if needed). I think no general netdev-setup thing is
needed, we have module parameters and library functions.

No ioctl for such things is needed either.
/sbin/ifconfig shouldn't mess with hardware data such as I/O address,
IRQ etc. - it should be a configuration tool for software protocols,
not for hardware (i.e. as /sbin/ip is).

My opinion of course.
-- 
Krzysztof Halasa
