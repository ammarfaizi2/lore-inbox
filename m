Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbWFTIBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbWFTIBb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWFTIBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:01:31 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:10696 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964993AbWFTIBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:01:30 -0400
Message-ID: <4497AB46.4000402@sgi.com>
Date: Tue, 20 Jun 2006 10:01:10 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Robin Holt <holt@sgi.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Carsten Otte <cotte@de.ibm.com>, bjorn_helgaas@hp.com
Subject: Re: [patch] do_no_pfn
References: <yq0psh5zenq.fsf@jaguar.mkp.net> <p73r71lpa6a.fsf@verdi.suse.de> <20060619224952.GA17685@lnx-holt.americas.sgi.com>
In-Reply-To: <20060619224952.GA17685@lnx-holt.americas.sgi.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robin Holt wrote:
> On Mon, Jun 19, 2006 at 03:06:05PM +0200, Andi Kleen wrote:
>> The big question is - why do you have pages without struct page? 
>> It seems ... wrong.
[snip]
> Are you saying the for the mspec pages we should extend the vmem_map,
> partially populate the regions for the mspec pages, mark those pages as
> uncached and reserved and then turn them over to the uncached allocator?
> Seems like we have done a lot of extra work to put a struct page behind
> a page which requires special handling.

Note that Bjorn Helgas has a case where he needs this as well.

We could fake the pages by giving them a struct page, but it really
makes no point as you say.

Cheers,
Jes
