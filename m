Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVCKR3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVCKR3I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 12:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbVCKR1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 12:27:43 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:56249 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261222AbVCKR1H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 12:27:07 -0500
Date: Fri, 11 Mar 2005 09:26:28 -0800
From: mike kravetz <kravetz@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64 NUMA memory fixup
Message-ID: <20050311172628.GB6360@w-mikek2.ibm.com>
References: <16942.30144.513313.26103@cargo.ozlabs.ibm.com> <20050310023613.23499386.akpm@osdl.org> <16945.23578.505529.220972@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16945.23578.505529.220972@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2005 at 07:51:38PM +1100, Paul Mackerras wrote:
> 
> Anyway, the ultimate reason seems to be that the numa.c code is
> assuming that an address value and a size value occupy the same number
> of cells.  On the G5 we have #address-cells = 2 but #size-cells = 1.
> Previously this didn't matter because we used the values in lmb.memory
> for the free_bootmem_node calls.  Those values are obtained in prom.c
> by scanning the memory nodes, using the correct number of cells.  With
> Mike's patch we rely instead on the values obtained by the numa.c
> code, which uses read_cell_ul() for both address and size values, and
> that just uses prom_n_size_cells() to know how many cells to parse.
> It really needs to use prom_n_addr_cells() when parsing an address
> value.
> 

Thanks Paul!!! That was more than I expected when I asked if you
could recreate on your G5 and provide me more info for analysis.
I'll work on creating a new version of the patch.

-- 
Mike
