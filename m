Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbVAMOyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVAMOyS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 09:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVAMOwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 09:52:21 -0500
Received: from ponzo.noc.sonic.net ([64.142.18.11]:40110 "HELO ponzo.sonic.net")
	by vger.kernel.org with SMTP id S261642AbVAMOuc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 09:50:32 -0500
Date: Thu, 13 Jan 2005 06:50:29 -0800
From: Scott Doty <scott@sonic.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.28(+?): Strange ARP problem
Message-ID: <20050113145029.GA22622@sonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-PGP-Key: http://sonic.net/~scott/gpgkey.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We use Linux extensively here at Sonic.net.  Our web servers have two
NIC's -- a NIC with a public IP address, and a NIC on our SAN (with NetApps).

When we tried to upgrade to 2.4.28, we encountered a problem with NetApp
reachability, which turns out to have been a problem with ARP:  we
were seeing two ARP entries for the NetApp IP's.  One would be correct, and
one would be "incomplete".

Occasionally, a system would glom onto the incomplete entry, and NFS
connectivity would tank.  This doesn't happen with 2.4.27.

We'd like to upgrade to 2.4.29-rc2, but we have much trepidation about doing
so.  I certainly don't want to treat the list as "our own personal help
desk" (as warned about in the FAQ), but was hoping someone could shed some
light on the problem.  I think either myself or one of our guys can write a
patch to fix it, if someone would point us in the right direction.

Thank you,

 -Scott
