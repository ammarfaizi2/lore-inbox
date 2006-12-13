Return-Path: <linux-kernel-owner+w=401wt.eu-S932473AbWLMCwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932473AbWLMCwB (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 21:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932500AbWLMCwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 21:52:01 -0500
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:49167 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932473AbWLMCwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 21:52:00 -0500
X-Greylist: delayed 2011 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Dec 2006 21:52:00 EST
Date: Tue, 12 Dec 2006 21:18:07 -0500
From: Kyle McMartin <kyle@parisc-linux.org>
To: linux-kernel@vger.kernel.org
Subject: Re: mapping PCI registers with write combining (and PAT on x86)...
Message-ID: <20061213021807.GW4044@athena.road.mcmartin.ca>
References: <adalklcu5w3.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adalklcu5w3.fsf@cisco.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 02:05:32PM -0800, Roland Dreier wrote:
> 	#if defined(__mc68000__)
<snip>
> 	#warning What do we have to do here??
> 	#endif
> 		if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
> 				     vma->vm_end - vma->vm_start, vma->vm_page_prot))
> 			return -EAGAIN;
> 		return 0;
> 

Wow, that should probably take the cake for the ugliest snippet
of code in the kernel.

--Kyle
