Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263810AbUAOW75 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 17:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbUAOW6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 17:58:50 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:15034 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S263777AbUAOW6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 17:58:00 -0500
Date: Thu, 15 Jan 2004 14:56:58 -0800
To: Grant Grundler <iod00d@hp.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, jeremy@sgi.com
Subject: Re: [PATCH] readX_relaxed interface
Message-ID: <20040115225658.GA9389@sgi.com>
Mail-Followup-To: Grant Grundler <iod00d@hp.com>,
	linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
	linux-ia64@vger.kernel.org, jeremy@sgi.com
References: <20040115204913.GA8172@sgi.com> <20040115221640.GA11283@cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040115221640.GA11283@cup.hp.com>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 15, 2004 at 02:16:40PM -0800, Grant Grundler wrote:
> Outside the context of PCI-X Relaxed Ordering, this violates PCI
> ordering rules. Any patches to drivers *using* the new readb()
> variants in effect work around this violation. I"m ok with that - just
> want it to be clear.

Yep, that's an advantage of this API--you only use it when you know it's
ok to violate those rules.

> PCI-X support will need a different interface
> (eg pcix_enable_relaxed_ordering()) to support
> it's form of "Relaxed Ordering".

Right, seperate issue.

> > If it looks ok, I'll add in macros for the other arches and send it out
> > for inclusion.
> 
> It looks ok to me.

Great, thanks.

Jesse
