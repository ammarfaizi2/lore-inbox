Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpOXEQNYstx/TT82GMSIUQHA9YA==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Mon, 05 Jan 2004 23:19:03 +0000
Message-ID: <03fb01c415a4$e5c417f0$d100000a@sbs2003.local>
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Date: Mon, 29 Mar 2004 16:45:44 +0100
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: <Administrator@smtp.paston.co.uk>
Cc: <colpatch@us.ibm.com>, <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@digeo.com>
Subject: Re: [TRIVIAL PATCH] Ensure pfn_to_nid() is always defined for i386
In-Reply-To: <20040105225340.GB1882@matchmail.com>
References: <3FE74984.3000602@us.ibm.com> <1814780000.1072139199@flay> <20040105225340.GB1882@matchmail.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:45:45.0593 (UTC) FILETIME=[E64E5690:01C415A4]

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

