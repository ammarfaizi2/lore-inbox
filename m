Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965047AbWFTIlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965047AbWFTIlE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 04:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965146AbWFTIlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 04:41:04 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:29899 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965047AbWFTIlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 04:41:02 -0400
Message-ID: <4497B490.90303@sgi.com>
Date: Tue, 20 Jun 2006 10:40:48 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Carsten Otte <cotte@de.ibm.com>, bjorn_helgaas@hp.com
Subject: Re: [patch] do_no_pfn
References: <yq0psh5zenq.fsf@jaguar.mkp.net> <20060619224952.GA17685@lnx-holt.americas.sgi.com> <4497AB46.4000402@sgi.com> <200606201013.10353.ak@suse.de>
In-Reply-To: <200606201013.10353.ak@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Tuesday 20 June 2006 10:01, Jes Sorensen wrote:
>> We could fake the pages by giving them a struct page, but it really
>> makes no point as you say.
> 
> I think it would be better if you gave them struct pages instead 
> of messing up core vm with such strange hooks.
> 
> Or alternatively code this in a different way. There are drivers
> who map IO memory into user space without needing hacks like that.
> Usually they just tweak the page tables directly on mmap.

Please go back and read the old threads on this for all the details,
I would miss half the points if I was to try and restate it all from
memory.

Doing this at mmap time does not work, you want NUMA node locality.
It has to be done through first touch mappings.

Jes
