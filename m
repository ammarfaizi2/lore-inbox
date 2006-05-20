Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWETAf3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWETAf3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 20:35:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWETAf3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 20:35:29 -0400
Received: from holly.csn.ul.ie ([193.1.99.76]:63417 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1751446AbWETAf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 20:35:28 -0400
Date: Sat, 20 May 2006 01:35:25 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet.skynet.ie
To: Andrew Morton <akpm@osdl.org>
Cc: evil@g-house.de, linux-kernel@vger.kernel.org, apw@shadowen.org
Subject: Re: SCSI ABORT with 2.6.17-rc4-mm1
In-Reply-To: <20060519163038.7236c8e3.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0605200133040.12335@skynet.skynet.ie>
References: <62331.192.18.1.5.1148071784.squirrel@housecafe.dyndns.org>
 <20060519141032.23de6eee.akpm@osdl.org> <20060519225746.GA11883@skynet.ie>
 <20060519163038.7236c8e3.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2006, Andrew Morton wrote:

> mel@csn.ul.ie (Mel Gorman) wrote:
>>
>> I am struggling to see how the alignment patches or
>>  arch-independent-zone-sizing would clobber the mapping of the ACPI table :(
>
> hm.  Well something did it ;)
>

Obviously. One option is to back out 
have-x86_64-use-add_active_range-and-free_area_init_nodes.patch and see 
what happens on Christian's machine.

>> > I also managed to provoke "Too many memory regions,
>> > truncating" out of it.
>> >
>>
>>  "Too many memory regions, truncating" is of concern because memory will be
>>  effectively lost. Is this on x86_64 as well? If so, I need to submit a
>>  patch that sets CONFIG_MAX_ACTIVE_REGIONS to 128 on x86_64 which is the
>>  same value of E820MAX. This is similar to what PPC64 does for LMB regions
>>  (see MAX_ACTIVE_REGIONS in arch/powerpc/Kconfig for example). If it's not
>>  x86_64, what arch does it occur on?
>
> Yes, it's x86_64.  It kind of went away though.  I seem to have been
> finding various .config combinations which cause x86_64 to die horridly -
> that was one.
>

Can you post up some of the configs and I'll see can I reproduce it 
locally please?

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
