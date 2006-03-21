Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965111AbWCUU51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965111AbWCUU51 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 15:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965112AbWCUU51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 15:57:27 -0500
Received: from test-iport-1.cisco.com ([171.71.176.117]:20853 "EHLO
	test-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S965108AbWCUU50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 15:57:26 -0500
To: "Sean Hefty" <sean.hefty@intel.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
       <openib-general@openib.org>
Subject: Re: [PATCH 4/6 v2] IB: address translation to map IP toIB addresses (GIDs)
X-Message-Flag: Warning: May contain useful information
References: <ORSMSX401FRaqbC8wSA0000000d@orsmsx401.amr.corp.intel.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 21 Mar 2006 12:57:24 -0800
In-Reply-To: <ORSMSX401FRaqbC8wSA0000000d@orsmsx401.amr.corp.intel.com> (Sean Hefty's message of "Mon, 6 Mar 2006 15:31:58 -0800")
Message-ID: <adabqvza53f.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 21 Mar 2006 20:57:25.0115 (UTC) FILETIME=[0E5674B0:01C64D2A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > +struct workqueue_struct *rdma_wq;
 > +EXPORT_SYMBOL(rdma_wq);

Sean, I don't think I saw an answer when I asked you this before.  Why
is ib_addr exporting a workqueue?  Is there some sort of ordering
constraint that is forcing other modules to go through the same
workqueue for things?

This seems like a very fragile internal thing to be exposing, and I'm
wondering if there's a better way to handle it.

 - R.
