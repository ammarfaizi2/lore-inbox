Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262726AbRE3MjW>; Wed, 30 May 2001 08:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262761AbRE3MjM>; Wed, 30 May 2001 08:39:12 -0400
Received: from femail17.sdc1.sfba.home.com ([24.0.95.144]:52625 "EHLO
	femail17.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S262726AbRE3MjH>; Wed, 30 May 2001 08:39:07 -0400
Message-ID: <3B14E9DE.75A65F04@didntduck.org>
Date: Wed, 30 May 2001 08:38:54 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mdaljeet@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: pte_page
In-Reply-To: <CA256A5C.002E4CF0.00@d73mta01.au.ibm.com> <3B14E70F.F7E7D4BA@didntduck.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> 
> mdaljeet@in.ibm.com wrote:
> >
> > I use the 'pgt_offset', 'pmd_offset', 'pte_offset' and 'pte_page' inside a
> > module to get the physical address of a user space virtual address. The
> > physical address returned by 'pte_page' is not page aligned whereas the
> > virtual address was page aligned. Can somebody tell me the reason?
> >
> > Also, can i use these functions to get the physical address of a kernel
> > virtual address using init_mm?
> 
> pte_page() returns the struct page * for the page, not the page
> address.  To get the physical address of a page use __pa(virtaddr), but
> this works if and only if the page is not highmem and not vmalloced.

Oops, I forgot that you said user page...  __pa() only works for kernel
addresses.  I don't see any other macros that can help you.  Maybe one
of the VM gurus can add something here?

-- 

						Brian Gerst
