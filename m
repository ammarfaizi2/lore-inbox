Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030460AbWJYOLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030460AbWJYOLK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 10:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030457AbWJYOLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 10:11:10 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:15289 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S1030455AbWJYOLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 10:11:07 -0400
To: Grant Grundler <grundler@parisc-linux.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       John Partridge <johnip@sgi.com>
Subject: Re: Ordering between PCI config space writes and MMIO reads?
X-Message-Flag: Warning: May contain useful information
References: <adafyddcysw.fsf@cisco.com>
	<20061025063022.GC12319@colo.lackof.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 25 Oct 2006 07:11:06 -0700
In-Reply-To: <20061025063022.GC12319@colo.lackof.org> (Grant Grundler's message of "Wed, 25 Oct 2006 00:30:22 -0600")
Message-ID: <ada3b9cbi4l.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 25 Oct 2006 14:11:06.0723 (UTC) FILETIME=[69BC8B30:01C6F83F]
Authentication-Results: sj-dkim-1.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I'm looking at arch/ia64/pci/pci.c.
 > Wouldn't it be reasonable to include memory barriers around calls
 > to SAL config space access functions?

It's reasonable, but is there a memory barrier strong enough to
guarantee that a config write has actually completed?

 - R.
