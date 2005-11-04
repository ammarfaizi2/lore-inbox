Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbVKDQNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbVKDQNd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 11:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbVKDQNd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 11:13:33 -0500
Received: from dvhart.com ([64.146.134.43]:54962 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1751592AbVKDQNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 11:13:32 -0500
Date: Fri, 04 Nov 2005 08:13:28 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Linus Torvalds <torvalds@osdl.org>, Andy Nelson <andy@thermo.lanl.gov>
Cc: akpm@osdl.org, arjan@infradead.org, arjanv@infradead.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mel@csn.ul.ie, mingo@elte.hu,
       nickpiggin@yahoo.com.au
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Message-ID: <331390000.1131120808@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.64.0511040738540.27915@g5.osdl.org>
References: <20051104145628.90DC71845CE@thermo.lanl.gov> <Pine.LNX.4.64.0511040738540.27915@g5.osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So I suspect Martin's 25% is a lot more accurate on modern hardware (which 
> means x86, possibly Power. Nothing else much matters).

It was PPC64, if that helps.
 
>> If your and other kernel developer's (<<0.01% of the universe) kernel
>> builds slow down by 5% and my and other people's simulations (perhaps 
>> 0.01% of the universe) speed up by a factor up to 3 or 4, who wins? 
> 
> First off, you won't speed up by a factor of three or four. Not even 
> _close_. 

Well, I think it depends on the workload a lot. However fast your TLB is,
if we move from "every cacheline read requires is a TLB miss" to "every
cacheline read is a TLB hit" that can be a huge performance knee however
fast your TLB is. Depends heavily on the locality of reference and size
of data set of the application, I suspect.

M.

