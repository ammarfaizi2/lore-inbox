Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbWFTJgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWFTJgI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 05:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbWFTJgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 05:36:08 -0400
Received: from cantor2.suse.de ([195.135.220.15]:40074 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030213AbWFTJgG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 05:36:06 -0400
From: Andi Kleen <ak@suse.de>
To: Jes Sorensen <jes@sgi.com>
Subject: Re: [patch] do_no_pfn
Date: Tue, 20 Jun 2006 11:35:53 +0200
User-Agent: KMail/1.9.3
Cc: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Carsten Otte <cotte@de.ibm.com>, bjorn_helgaas@hp.com
References: <yq0psh5zenq.fsf@jaguar.mkp.net> <200606201048.10545.ak@suse.de> <4497BBFE.6000703@sgi.com>
In-Reply-To: <4497BBFE.6000703@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606201135.53824.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> One struct page for a random single page here, another for a single
> random page there. And the risk that someone will start walking the
> pages and dereference and cause data corruption. As explained before,
> it's a bad idea.

Note sure what your point is. Why should they cause memory corruption?

Allowing struct page less VM is worse. If you add that then people
will use it for other stuff, and eventually we got a two class
VM. All not very good.

-Andi
