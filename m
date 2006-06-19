Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751248AbWFSIyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWFSIyk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 04:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWFSIyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 04:54:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:29900 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751248AbWFSIyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 04:54:38 -0400
From: Andi Kleen <ak@suse.de>
To: Zoltan Menyhart <Zoltan.Menyhart@bull.net>
Subject: Re: [discuss] Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
Date: Mon, 19 Jun 2006 10:54:29 +0200
User-Agent: KMail/1.8
Cc: discuss@x86-64.org, Chase Venters <chase.venters@clientec.com>,
       Brent Casavant <bcasavan@sgi.com>, Jes Sorensen <jes@sgi.com>,
       Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
       libc-alpha@sourceware.org, vojtech@suse.cz, linux-ia64@vger.kernel.org
References: <200606140942.31150.ak@suse.de> <200606170855.49123.ak@suse.de> <44966383.1030006@bull.net>
In-Reply-To: <44966383.1030006@bull.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606191054.29543.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Probably I have not explained it correctly:
> - The "information page" (that includes the current CPU no.) is not a
>   per CPU page

If it isn't then you can't figure out the current CPU/node for a thread.

Anyways I think we're talking past each other. Your approach might
even work on ia64 (at least if you're willing to add a lot of cost
to the context switch). You presumably could implement vgetcpu()
internally with an approach like this (although with IA64's fast 
EPC calls it seems a bit pointless) 

It just won't work on x86. 

-Andi
