Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWJAQLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWJAQLe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 12:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWJAQLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 12:11:34 -0400
Received: from sj-iport-6.cisco.com ([171.71.176.117]:6776 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1751225AbWJAQLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 12:11:33 -0400
To: Jeff Garzik <jeff@garzik.org>
Cc: markus.lidel@shadowconnect.com, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] I2O: mark i2o_config broken on 64-bit
X-Message-Flag: Warning: May contain useful information
References: <20061001155636.GA6836@havoc.gtf.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Sun, 01 Oct 2006 09:11:30 -0700
In-Reply-To: <20061001155636.GA6836@havoc.gtf.org> (Jeff Garzik's message of "Sun, 1 Oct 2006 11:56:36 -0400")
Message-ID: <adalko0xbgt.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 01 Oct 2006 16:11:32.0163 (UTC) FILETIME=[42853130:01C6E574]
Authentication-Results: sj-dkim-4.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > -			//TODO 64bit fix
 > +			//FIXME: broken on 64-bit
 >  			sg[i].addr_bus = (u32) p->phys;

This looks worse than just broken on 64 bit.  I didn't even attempt to
understand what's going on here, but would this even work on 32 bit
systems that have physical addresses above 4 gigs (eg i386 with PAE)?

 - R.
