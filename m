Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262933AbVCQBF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262933AbVCQBF7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 20:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbVCQBF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 20:05:59 -0500
Received: from adsl-69-233-54-133.dsl.pltn13.pacbell.net ([69.233.54.133]:64525
	"EHLO bastard.smallmerchant.com") by vger.kernel.org with ESMTP
	id S262933AbVCQBFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 20:05:30 -0500
Message-ID: <4238D7E2.2060002@tupshin.com>
Date: Wed, 16 Mar 2005 17:05:38 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Cc: Rik van Riel <riel@redhat.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Keir Fraser <Keir.Fraser@cl.cam.ac.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, kurt@garloff.de, Ian.Pratt@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk
Subject: Re: [PATCH] Xen/i386 cleanups - AGP bus/phys cleanups
References: <E1DBX0o-0000sV-00@mta1.cl.cam.ac.uk>	<16952.41973.751326.592933@cargo.ozlabs.ibm.com>	<200503161406.01788.jbarnes@engr.sgi.com>	<Pine.LNX.4.61.0503161853380.23084@chimarrao.boston.redhat.com> <16952.53719.150647.638710@cargo.ozlabs.ibm.com>
In-Reply-To: <16952.53719.150647.638710@cargo.ozlabs.ibm.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:

>Rik van Riel writes:
>
>  
>
>>Thing is, the rest of the kernel uses virt_to_phys for
>>two different things.  Only one of them has to do with
>>the real physical address, the other is about getting
>>the page frame number.
>>    
>>
>
>So fix the places that are using virt_to_phys to get the page frame
>number to use virt_to_pfn instead. :)
>
>  
>
>>On native x86, x86-64 and others, the page frame number
>>and physical address are directly related to each other.
>>Under Xen, however, the two are different - and the
>>AGPGART really needs to have the physical address ;)
>>    
>>
>
>If Xen is letting the kernel program the GART, you just lost any
>memory isolation between partitions you might have been trying to
>enforce. :)
>  
>
Since xen only lets the  dom0 (privileged domain) program the GART, all 
of the domU's  (non-privileged domains) are still isolated from each other.

-Tupshin
