Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpN+ZirFFxZLFSlyIcp5g69FAMw==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Mon, 05 Jan 2004 22:58:26 +0000
Message-ID: <03d601c415a4$df99b970$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft CDO for Exchange 2000
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Date: Mon, 29 Mar 2004 16:45:34 +0100
From: "Mike Fedyk" <mfedyk@matchmail.com>
To: <Administrator@smtp.paston.co.uk>
Cc: <colpatch@us.ibm.com>, <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@digeo.com>
Subject: Re: [TRIVIAL PATCH] Ensure pfn_to_nid() is always defined for i386
Mail-Followup-To: "Martin J. Bligh" <mbligh@aracnet.com>,
	colpatch@us.ibm.com, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@digeo.com>
References: <3FE74984.3000602@us.ibm.com> <1814780000.1072139199@flay>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1814780000.1072139199@flay>
User-Agent: Mutt/1.5.4i
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:45:36.0562 (UTC) FILETIME=[E0EC5120:01C415A4]

On Mon, Dec 22, 2003 at 04:26:40PM -0800, Martin J. Bligh wrote:
> + * for now assume that 64Gb is max amount of RAM for whole system
> + *    64Gb / 4096bytes/page = 16777216 pages
> + */
> +#define MAX_NR_PAGES 16777216
> +#define MAX_ELEMENTS 256
> +#define PAGES_PER_ELEMENT (MAX_NR_PAGES/MAX_ELEMENTS)

Why not do the calculation in the define, and use PAGE_SIZE?

If PAGE_SIZE isn't 4k will it break the rest of this code, or will the
calculations make sence with larger PAGE_SIZE?

Might as well make it easier to go in the direction of variable PAGE_SIZE
instead of keeping the assumption.
