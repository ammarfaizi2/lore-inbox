Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbVIGS2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbVIGS2w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 14:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbVIGS2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 14:28:52 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:50644 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932197AbVIGS2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 14:28:51 -0400
Subject: Re: [PATCH] i386: single node SPARSEMEM fix
From: Dave Hansen <haveblue@us.ibm.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Magnus Damm <magnus@valinux.co.jp>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>,
       "A. P. Whitcroft [imap]" <andyw@uk.ibm.com>
In-Reply-To: <512850000.1126117362@flay>
References: <20050906035531.31603.46449.sendpatchset@cherry.local>
	 <1126114116.7329.16.camel@localhost>  <512850000.1126117362@flay>
Content-Type: text/plain
Date: Wed, 07 Sep 2005 11:27:54 -0700
Message-Id: <1126117674.7329.27.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-07 at 11:22 -0700, Martin J. Bligh wrote:
> CONFIG_NUMA was meant to (and did at one point) support both NUMA and flat
> machines. This is essential in order for the distros to support it - same
> will go for sparsemem.

That's a different issue.  The current code works if you boot a NUMA=y
SPARSEMEM=y machine with a single node.  The current Kconfig options
also enforce that SPARSEMEM depends on NUMA on i386.

Magnus would like to enable SPARSEMEM=y while CONFIG_NUMA=n.  That
requires some Kconfig changes, as well as an extra memory present call.
I'm questioning why we need to do that when we could never do
DISCONTIG=y while NUMA=n on i386.

-- Dave

