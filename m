Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261311AbVCKTVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261311AbVCKTVv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 14:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbVCKTVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 14:21:36 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:17817 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261529AbVCKTRr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 14:17:47 -0500
Subject: Re: User mode drivers: part 2: PCI device handling (patch 1/2 for
	2.6.11)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       peterc@gelato.unsw.edu.au
In-Reply-To: <1110518308.1949.67.camel@cube>
References: <1110518308.1949.67.camel@cube>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110568542.15927.76.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 11 Mar 2005 19:15:46 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> You forgot the PCI domain (a.k.a. hose, phb...) number.
> Also, you might encode bus,slot,function according to
> the PCI spec. So that gives:
> 
> long usr_pci_open(unsigned pcidomain, unsigned devspec, __u64 dmamask);

Still insufficient because the device might be hotplugged on you. You
need a file handle that has the expected revocation effects on unplug
and refcounts

Alan

