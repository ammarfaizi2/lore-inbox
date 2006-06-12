Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751875AbWFLLVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbWFLLVu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 07:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbWFLLVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 07:21:50 -0400
Received: from ns1.suse.de ([195.135.220.2]:20408 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751875AbWFLLVu (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 07:21:50 -0400
From: Andi Kleen <ak@suse.de>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH]: Adding a counter in vma to indicate the number of physical pages backing it
Date: Mon, 12 Jun 2006 13:17:44 +0200
User-Agent: KMail/1.9.3
Cc: rohitseth@google.com, Andrew Morton <akpm@osdl.org>, Linux-mm@kvack.org,
       Linux-kernel@vger.kernel.org
References: <1149903235.31417.84.camel@galaxy.corp.google.com> <1150042142.3131.82.camel@laptopd505.fenrus.org>
In-Reply-To: <1150042142.3131.82.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606121317.44139.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 June 2006 18:09, Arjan van de Ven wrote:
> On Fri, 2006-06-09 at 18:33 -0700, Rohit Seth wrote:
> > Below is a patch that adds number of physical pages that each vma is
> > using in a process.  Exporting this information to user space
> > using /proc/<pid>/maps interface.
> 
> is it really worth bloating the vma struct for this? there are quite a
> few workloads that have a gazilion vma's, and this patch adds both
> memory usage and cache pressure to those workloads...

I agree it's a bad idea. smaps is only a debugging kludge anyways
and it's not a good idea to we bloat core data structures for it.

-Andi
