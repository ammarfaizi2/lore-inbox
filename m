Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932371AbVLPSlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932371AbVLPSlP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 13:41:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932364AbVLPSlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 13:41:15 -0500
Received: from omx3-ext.sgi.com ([192.48.171.25]:12231 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932371AbVLPSlO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 13:41:14 -0500
Message-ID: <007001c60270$1066c0c0$6f00a8c0@comcast.net>
From: "John Hawkes" <hawkes@sgi.com>
To: "Luck, Tony" <tony.luck@intel.com>, "Robin Holt" <holt@sgi.com>
Cc: "Tony Luck" <tony.luck@gmail.com>, "Andrew Morton" <akpm@osdl.org>,
       <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       "Jack Steiner" <steiner@sgi.com>, "Keith Owens" <kaos@sgi.com>,
       "Dimitri Sivanich" <sivanich@sgi.com>
References: <20051216024252.27639.63120.sendpatchset@tomahawk.engr.sgi.com> <20051216122854.GA10375@lnx-holt.americas.sgi.com> <20051216173342.GA12205@agluck-lia64.sc.intel.com>
Subject: Re: [PATCH] ia64: disable preemption in udelay()
Date: Fri, 16 Dec 2005 10:39:34 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Luck, Tony" <tony.luck@intel.com>
...
> A good question ... I'm going to put John's change in as-is for now so
> that 2.6.15 can benefit from the reduced code size of the out-of-line
> and avoid the ugly bug when preemption is enabled on a drifty system.

Okay, but I'll propose some changes to that soon, probably using Robin Holt's
suggestions.  I'm concerned about the impact of interrupts outside of the
inner loop and inside the outer loop, which would increase the effective delay
time.

John Hawkes

