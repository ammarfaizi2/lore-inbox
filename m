Return-Path: <linux-kernel-owner+w=401wt.eu-S1751871AbWLNAeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbWLNAeY (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 19:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751872AbWLNAeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 19:34:24 -0500
Received: from ozlabs.org ([203.10.76.45]:59399 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871AbWLNAeX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 19:34:23 -0500
X-Greylist: delayed 2124 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 19:34:23 EST
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17792.37821.279813.601921@cargo.ozlabs.ibm.com>
Date: Thu, 14 Dec 2006 10:58:53 +1100
From: Paul Mackerras <paulus@samba.org>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, cbe-oss-dev@ozlabs.org,
       linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andy Whitcroft <apw@shadowen.org>,
       Michael Kravetz <mkravetz@us.ibm.com>, hch@infradead.org,
       Jeremy Kerr <jk@ozlabs.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Bug: early_pfn_in_nid() called when not early
In-Reply-To: <20061213231717.GC10708@monkey.ibm.com>
References: <200612131920.59270.arnd@arndb.de>
	<20061213231717.GC10708@monkey.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz writes:

> Thanks for the debug work!  Just curious if you really need
> CONFIG_NODES_SPAN_OTHER_NODES defined for your platform?  Can you get
> those types of memory layouts?  If not, an easy/immediate fix for you
> might be to simply turn off the option.

We really need CONFIG_NODES_SPAN_OTHER_NODES for pSeries.  Since we
can build a single kernel binary that runs on both Cell and pSeries,
the Cell code needs to be able to work with that option turned on.

Paul.
