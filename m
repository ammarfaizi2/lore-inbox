Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbULJFUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbULJFUI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 00:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbULJFUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 00:20:08 -0500
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:40892 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261725AbULJFUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 00:20:03 -0500
Message-ID: <41B931FC.8040109@yahoo.com.au>
Date: Fri, 10 Dec 2004 16:19:56 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Hugh Dickins <hugh@veritas.com>, Christoph Lameter <clameter@sgi.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-mm@kvack.org, linux-ia64@vger.kernel.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: page fault scalability patch V12 [0/7]: Overview and	performance
 tests
References: <Pine.LNX.4.44.0412091830580.17648-300000@localhost.localdomain>	 <41B92567.8070809@yahoo.com.au>  <41B92C11.80106@yahoo.com.au> <1102655177.22746.29.camel@gaston>
In-Reply-To: <1102655177.22746.29.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> On Fri, 2004-12-10 at 15:54 +1100, Nick Piggin wrote:
> 
>>Nick Piggin wrote:
>>
>>The page-freed-before-update_mmu_cache issue can be solved in that way,
>>not the set_pte and update_mmu_cache not performed under the same ptl
>>section issue that you raised.
> 
> 
> What is the problem with update_mmu_cache ? It doesn't need to be done
> in the same lock section since it's approx. equivalent to a HW fault,
> which doesn't take the ptl...
> 

I don't think a problem has been observed, I think Hugh was just raising
it as a general issue.
