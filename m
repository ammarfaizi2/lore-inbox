Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbUKCRN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbUKCRN2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 12:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbUKCRN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 12:13:27 -0500
Received: from canuck.infradead.org ([205.233.218.70]:6154 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261746AbUKCRJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 12:09:59 -0500
Subject: Re: [patch] remove direct mem_map refs for x86-64
From: Arjan van de Ven <arjan@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Matt Tolentino <metolent@snoqualmie.dp.intel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041103170208.GB1514@wotan.suse.de>
References: <200411031647.iA3GlmBm016951@snoqualmie.dp.intel.com>
	 <1099499567.2813.24.camel@laptop.fenrus.org>
	 <20041103170208.GB1514@wotan.suse.de>
Content-Type: text/plain
Message-Id: <1099501787.2813.29.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Wed, 03 Nov 2004 18:09:47 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-03 at 18:02 +0100, Andi Kleen wrote:
> On Wed, Nov 03, 2004 at 05:32:47PM +0100, Arjan van de Ven wrote:
> > On Wed, 2004-11-03 at 08:47 -0800, Matt Tolentino wrote:
> > > -                       page = pgdat->node_mem_map + i;
> > > -		total++;
> > > +			page = pfn_to_page(pgdat->node_start_pfn + i);
> > > +			total++;
> > 
> > this can't be correct... pfn_to_page starts to count from address 0
> > while the original code starts from the start of the node..
> 
> That is why he adds node_start_pfn

DOH yes; sorry.


