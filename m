Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWEIQO7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWEIQO7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751306AbWEIQO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:14:59 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:30471 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751287AbWEIQO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:14:58 -0400
Message-ID: <4460BFE6.4060504@shadowen.org>
Date: Tue, 09 May 2006 17:14:30 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mike kravetz <kravetz@us.ibm.com>
CC: Michael Ellerman <michael@ellerman.id.au>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, haveblue@us.ibm.com
Subject: Re: [PATCH] SPARSEMEM + NUMA can't handle unaligned memory regions?
References: <20060509070343.57853679F2@ozlabs.org> <44609A7B.7010103@shadowen.org> <20060509160528.GA3168@w-mikek2.ibm.com>
In-Reply-To: <20060509160528.GA3168@w-mikek2.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mike kravetz wrote:
> On Tue, May 09, 2006 at 02:34:51PM +0100, Andy Whitcroft wrote:
> 
>>3) record the nid -- when we record the memory present in the system we
>>are passed the nid.
>>
>>Somehow the last of these seems the most logical given we have the
>>correct information at the time we record that we need to instantiate
>>the section.  So I had a quick go at something which seems to have come
>>out pretty clean.  Attached is a completly untested patch to show what I
>>am proposing.
> 
> 
> Looks sane to me.  I've always wanted to encode the nid in the section.
> But, never had a compelling reason to do so.
> 
> With this code in place, we could optimize the pfn_to_nid() routines to
> now obtain the nid from the section (rather than page struct).  However,
> I'm not sure this is worth the effort.

Well its only in there temporarily during init, its not in there once we
have allocated the section mem_map.

-apw
