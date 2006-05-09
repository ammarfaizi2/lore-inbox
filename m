Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751746AbWEIKYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbWEIKYw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 06:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751756AbWEIKYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 06:24:52 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:1030 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751746AbWEIKYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 06:24:52 -0400
Message-ID: <44606DD3.5080408@shadowen.org>
Date: Tue, 09 May 2006 11:24:19 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: michael@ellerman.id.au
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com
Subject: Re: [PATCH] SPARSEMEM + NUMA can't handle unaligned memory regions?
References: <20060509070343.57853679F2@ozlabs.org>	 <44605396.40507@shadowen.org> <1147165871.8704.14.camel@localhost.localdomain>
In-Reply-To: <1147165871.8704.14.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman wrote:
> On Tue, 2006-05-09 at 09:32 +0100, Andy Whitcroft wrote:
> 
>>Michael Ellerman wrote:
>>
>>>I can't believe I'm the first person to see this, so I imagine I'm missing
>>>something. Perhaps it's only an issue on powerpc?
>>>
>>>I have a machine with some memory at 0, then a hole, and then some more memory
>>>which doesn't start on a section boundary. This is causing the following
>>>crash:
>>>
>>>add_region nid 1 start_pfn 0x77c0 pages 0x840
>>>add_region nid 1 start_pfn 0x0 pages 0x6000
>>
>>Nasty, could you send me your full boot log and your config and I'll
>>have a look at it.  I can say this code has been booted on a lot of
>>power boxes and I've never seen that before!  :)
> 
> 
> Ah yeah, I seem to have neglected to mention it's a kdump boot :} Sorry.
> That's why we get the strangely aligned memory sections. The section
> starting at 0 is for the kdump kernel, the bit at 0x77c0 covers some
> firmware that's allocated there by the first kernel.
> 
> I can still give you a .config and log if you want it, but not 'til
> tomorrow morning.

Heh.  Well at least that makes more sense.  It would be good to have
them generally.  But no I'm not scared of where this odd alignment is
coming from I can look at what we can do about it.

Thanks.

-apw
