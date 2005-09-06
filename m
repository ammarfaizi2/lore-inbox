Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750912AbVIFUm5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbVIFUm5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 16:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbVIFUm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 16:42:57 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:20153 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1750903AbVIFUm4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 16:42:56 -0400
Date: Tue, 6 Sep 2005 22:42:21 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Valdis.Kletnieks@vt.edu
Cc: Miroslaw Mieszczak <mieszcz@zabrze.zigzag.pl>, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org
Subject: Re: Patch for link detection for R8169
Message-ID: <20050906204221.GB20862@electric-eye.fr.zoreil.com>
References: <431DA887.2010008@zabrze.zigzag.pl> <20050906194602.GA20862@electric-eye.fr.zoreil.com> <200509062002.j86K28R8019604@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509062002.j86K28R8019604@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> :
[...]

Ok, thanks for the hint.

Currently one can do 'ifconfig ethX up', check the link status, then try
to DHCP or whatever. Apparently a few drivers do not support tne detection
of link as presented above. So is it anything like a vendor requirement/a
standard (or should it be the new right way (TM)) or does the userspace
needs fixing wrt its expectation ?

The lack of irq means that netif_carrier_on/off can not be reliable until
the device is up. It is a bit worrying.

--
Ueimor
