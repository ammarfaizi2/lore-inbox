Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265994AbUAEXQI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 18:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265963AbUAEXQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 18:16:08 -0500
Received: from citrine.spiritone.com ([216.99.193.133]:7326 "EHLO
	citrine.spiritone.com") by vger.kernel.org with ESMTP
	id S266020AbUAEXPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 18:15:39 -0500
Date: Mon, 05 Jan 2004 15:15:33 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [TRIVIAL PATCH] Ensure pfn_to_nid() is always defined for i386
Message-ID: <5690000.1073344532@[10.10.2.4]>
In-Reply-To: <20040105225340.GB1882@matchmail.com>
References: <3FE74984.3000602@us.ibm.com> <1814780000.1072139199@flay> <20040105225340.GB1882@matchmail.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> + * for now assume that 64Gb is max amount of RAM for whole system
>> + *    64Gb / 4096bytes/page = 16777216 pages
>> + */
>> +#define MAX_NR_PAGES 16777216
>> +#define MAX_ELEMENTS 256
>> +#define PAGES_PER_ELEMENT (MAX_NR_PAGES/MAX_ELEMENTS)
> 
> Why not do the calculation in the define, and use PAGE_SIZE?
> 
> If PAGE_SIZE isn't 4k will it break the rest of this code, or will the
> calculations make sence with larger PAGE_SIZE?
> 
> Might as well make it easier to go in the direction of variable PAGE_SIZE
> instead of keeping the assumption.

The patch is just moving the code, not changing it ;-)
But yes, that value could probably be derived instead of hardcoded.
Separate patch though.

M.

