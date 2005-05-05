Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262162AbVEERxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262162AbVEERxh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 13:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262163AbVEERxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 13:53:37 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:19131 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262162AbVEERxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 13:53:35 -0400
Date: Thu, 5 May 2005 10:53:20 -0700
From: mike kravetz <kravetz@us.ibm.com>
To: Andy Whitcroft <apw@shadowen.org>
Cc: linuxppc64-dev@ozlabs.org, paulus@samba.org, anton@samba.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, haveblue@us.ibm.com
Subject: Re: [3/3] sparsemem memory model for ppc64
Message-ID: <20050505175320.GC3930@w-mikek2.ibm.com>
References: <E1DTQWH-0002We-I9@pinky.shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DTQWH-0002We-I9@pinky.shadowen.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 04, 2005 at 09:30:57PM +0100, Andy Whitcroft wrote:
> +	/*
> +	 * Note presence of first (logical/coalasced) LMB which will
> +	 * contain RMO region
> +	 */
> +	start_pfn = lmb.memory.region[0].physbase >> PAGE_SHIFT;
> +	end_pfn = start_pfn + (lmb.memory.region[0].size >> PAGE_SHIFT);
> +	memory_present(0, start_pfn, end_pfn);

I need to take a close look at this again, but I think this special
handling for the RMO region in unnecessary.  I added it in the 'early
days of SPARSE' when there were some 'bootstrap' issues and we needed
to initialize some memory before setting up the bootmem bitmap.  I'm
pretty sure all those issues have gone away.

-- 
Mike
