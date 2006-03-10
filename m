Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752143AbWCJAcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143AbWCJAcw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752139AbWCJAcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:32:51 -0500
Received: from test-iport-1.cisco.com ([171.71.176.117]:61345 "EHLO
	test-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1752136AbWCJAcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:32:51 -0500
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH 10 of 20] ipath - support for userspace apps using core driver
X-Message-Flag: Warning: May contain useful information
References: <71644dd19420ddb07a75.1141922823@localhost.localdomain>
	<ada4q27fban.fsf@cisco.com>
	<1141948516.10693.55.camel@serpentine.pathscale.com>
	<ada1wxbdv7a.fsf@cisco.com>
	<1141949262.10693.69.camel@serpentine.pathscale.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 09 Mar 2006 16:32:46 -0800
In-Reply-To: <1141949262.10693.69.camel@serpentine.pathscale.com> (Bryan O'Sullivan's message of "Thu, 09 Mar 2006 16:07:42 -0800")
Message-ID: <adawtf3cf69.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 10 Mar 2006 00:32:48.0243 (UTC) FILETIME=[282A4C30:01C643DA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Bryan> We're mapping some memory that the chip DMAs to into
    Bryan> userspace, so that user processes can spin on memory
    Bryan> locations without going through the kernel.  The
    Bryan> SetPageReserved hack is an attempt to stop the VM from
    Bryan> reclaiming those pages from us once a user process exits.

    Bryan> I realise that it's surely bogus, and I'd be thrilled to do
    Bryan> something correct instead.  We've tried doing both
    Bryan> SetPageReserved and get_page, but it hasn't work out too
    Bryan> well so far.

What's wrong with doing get_page()?  Surely the VM won't take pages
that you hold a reference to.

 - R.
