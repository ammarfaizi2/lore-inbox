Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbVAKT3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVAKT3a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 14:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262829AbVAKT3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 14:29:23 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:19855 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262189AbVAKT2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 14:28:46 -0500
Message-ID: <41E4295F.1010909@sgi.com>
Date: Tue, 11 Jan 2005 13:30:39 -0600
From: Ray Bryant <raybry@sgi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve Longerbeam <stevel@mvista.com>
CC: Andi Kleen <ak@muc.de>, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>
Subject: Re: page migration patchset
References: <41DB35B8.1090803@sgi.com> <m1wtusd3y0.fsf@muc.de> <41DB5CE9.6090505@sgi.com> <41DC34EF.7010507@mvista.com> <41E3F2DA.5030900@sgi.com> <41E42268.5090404@mvista.com>
In-Reply-To: <41E42268.5090404@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Longerbeam wrote:


> 
> isn't this already taken care of? read_swap_cache_async() is given
> a vma, and passes it to alloc_page_vma(). So if you have earlier
> changed the policy for that vma, the new policy will be used
> when allocating the page during the swap in.
> 
> Steve
> 

What if the policy associated with a vma is the default policy?
Then the page will be swapped in on the node that took the page
fault -- this is >>probably<< correct in most cases, but if a
page is accessed from several nodes, and predominately accessed
from a particular node, it can end up moving due to being swapped
out, and that is probably not what the application intended.

-- 
Best Regards,
Ray
-----------------------------------------------
                   Ray Bryant
512-453-9679 (work)         512-507-7807 (cell)
raybry@sgi.com             raybry@austin.rr.com
The box said: "Requires Windows 98 or better",
            so I installed Linux.
-----------------------------------------------
