Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262769AbRE3M1l>; Wed, 30 May 2001 08:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262773AbRE3M1b>; Wed, 30 May 2001 08:27:31 -0400
Received: from femail17.sdc1.sfba.home.com ([24.0.95.144]:20986 "EHLO
	femail17.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S262769AbRE3M1W>; Wed, 30 May 2001 08:27:22 -0400
Message-ID: <3B14E70F.F7E7D4BA@didntduck.org>
Date: Wed, 30 May 2001 08:26:55 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mdaljeet@in.ibm.com
CC: linux-kernel@vger.kernel.org
Subject: Re: pte_page
In-Reply-To: <CA256A5C.002E4CF0.00@d73mta01.au.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mdaljeet@in.ibm.com wrote:
> 
> I use the 'pgt_offset', 'pmd_offset', 'pte_offset' and 'pte_page' inside a
> module to get the physical address of a user space virtual address. The
> physical address returned by 'pte_page' is not page aligned whereas the
> virtual address was page aligned. Can somebody tell me the reason?
> 
> Also, can i use these functions to get the physical address of a kernel
> virtual address using init_mm?

pte_page() returns the struct page * for the page, not the page
address.  To get the physical address of a page use __pa(virtaddr), but
this works if and only if the page is not highmem and not vmalloced.

-- 

						Brian Gerst
