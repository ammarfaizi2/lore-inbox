Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161363AbWJYOGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161363AbWJYOGE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 10:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030457AbWJYOGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 10:06:04 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:47803 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1030459AbWJYOGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 10:06:00 -0400
To: Jack Steiner <steiner@sgi.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Jeff Garzik <jeff@garzik.org>,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       John Partridge <johnip@sgi.com>
Subject: Re: Ordering between PCI config space writes and MMIO reads?
X-Message-Flag: Warning: May contain useful information
References: <adafyddcysw.fsf@cisco.com> <20061024192210.GE2043@havoc.gtf.org>
	<20061024214724.GS25210@parisc-linux.org> <adar6wxbcwt.fsf@cisco.com>
	<20061024223631.GT25210@parisc-linux.org>
	<20061024232755.GA26521@sgi.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 25 Oct 2006 07:05:59 -0700
In-Reply-To: <20061024232755.GA26521@sgi.com> (Jack Steiner's message of "Tue, 24 Oct 2006 18:27:55 -0500")
Message-ID: <adaejswbid4.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 25 Oct 2006 14:05:59.0664 (UTC) FILETIME=[B2B70F00:01C6F83E]
Authentication-Results: sj-dkim-4.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > I'll check if there is any additional reordering that can occur AFTER the
 > PIO_WRITE_COUNT goes to zero.  If so, it would be at bus level - not in
 > shub or routers.

Unfortunately, at least in theory, the reordering can occur.  For
example a bridge on some card plugged into an SN slot is allowed to
reorder things too.

 - R.
