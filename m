Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbTIXB57 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 21:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbTIXB57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 21:57:59 -0400
Received: from palrel10.hp.com ([156.153.255.245]:51917 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S261240AbTIXB55 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 21:57:57 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16240.47156.771134.68028@napali.hpl.hp.com>
Date: Tue, 23 Sep 2003 14:16:36 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Luck, Tony" <tony.luck@intel.com>, "David S. Miller" <davem@redhat.com>,
       davidm@hpl.hp.com, davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au,
       bcrl@kvack.org, ak@suse.de, iod00d@hp.com, peterc@gelato.unsw.edu.au,
       linux-ns83820@kvack.org, linux-ia64@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: NS83820 2.6.0-test5 driver seems unstable on IA64
In-Reply-To: <1064350834.11760.4.camel@dhcp23.swansea.linux.org.uk>
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com>
	<1064350834.11760.4.camel@dhcp23.swansea.linux.org.uk>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 23 Sep 2003 22:00:34 +0100, Alan Cox <alan@lxorguk.ukuu.org.uk> said:

  >> Looking at a couple of ia64 build servers here I see zero unaligned
  >> access messages in the logs.

  Alan> Anyone who can deliver network traffic to your box can soon fix that...

Not if he's running Red Hat.  This is on a Red Hat 9 machine (x86,
just so you can't argue it's ia64-specific...):

 $ fgrep LOGLEVEL /etc/rc.sysinit
 /bin/dmesg -n $LOGLEVEL
 $ fgrep LOGLEVEL /etc/sysconfig/*
 /etc/sysconfig/init:LOGLEVEL=3

Red Hat users won't be bothered by unaligned messages.

	--david
