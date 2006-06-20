Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbWFTJMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWFTJMq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 05:12:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbWFTJMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 05:12:46 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:26062 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964987AbWFTJMp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 05:12:45 -0400
Message-ID: <4497BBFE.6000703@sgi.com>
Date: Tue, 20 Jun 2006 11:12:30 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Hugh Dickins <hugh@veritas.com>,
       Carsten Otte <cotte@de.ibm.com>, bjorn_helgaas@hp.com
Subject: Re: [patch] do_no_pfn
References: <yq0psh5zenq.fsf@jaguar.mkp.net> <200606201013.10353.ak@suse.de> <4497B490.90303@sgi.com> <200606201048.10545.ak@suse.de>
In-Reply-To: <200606201048.10545.ak@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>> Please go back and read the old threads on this for all the details,
>> I would miss half the points if I was to try and restate it all from
>> memory.
> 
> Shouldn't these points be in the patch submission description? 

You expect people to go look for things on random mailing lists when you
post it, but you don't care to search the archives yourself.... och
well.

http://www.gelato.unsw.edu.au/archives/linux-ia64/0603/index.html#17543

http://www.ussg.iu.edu/hypermail/linux/kernel/0604.2/index.html#0652
http://www.ussg.iu.edu/hypermail/linux/kernel/0604.3/index.html#0029

>> Doing this at mmap time does not work, you want NUMA node locality.
>> It has to be done through first touch mappings.
> 
> Then create struct page *s.

One struct page for a random single page here, another for a single
random page there. And the risk that someone will start walking the
pages and dereference and cause data corruption. As explained before,
it's a bad idea.

Jes
