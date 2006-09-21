Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751323AbWIUSVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWIUSVr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 14:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWIUSVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 14:21:47 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56812 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751324AbWIUSVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 14:21:46 -0400
Subject: Re: Flushing writes to PCI devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Bill Waddington <william.waddington@beezmo.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1158862442.29551.22.camel@sardonyx>
References: <fa.gbsNbubc34pqWPOxWCntrwUyt68@ifi.uio.no>
	 <Pine.LNX.4.44L0.0609201423480.7265-100000@iolanthe.rowland.org>
	 <fa.V4O8HKrhUddxYm5+ixVbyZzPybE@ifi.uio.no>
	 <6263h29e4o17ok032m8rv11p4u6547ngk0@4ax.com>
	 <1158862442.29551.22.camel@sardonyx>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 21 Sep 2006 19:45:56 +0100
Message-Id: <1158864356.11109.171.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-09-21 am 11:14 -0700, ysgrifennodd Bryan O'Sullivan:
> Yes.  If your device requires that writes to some locations in MMIO
> space be performed in a specific order, you must explicitly do this in
> your driver.  Intel CPUs will flush posted writes out of order, for
> example.

According to the docs I have here if the pci target area is
prefetchable/postwritable or has MTRRs set specifically to do this (eg
video ram).

There is no ordering guarantee between PCI and main memory however.

Alan

