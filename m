Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266806AbUHXHvC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266806AbUHXHvC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 03:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267165AbUHXHvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 03:51:02 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:11376 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266806AbUHXHu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 03:50:58 -0400
Message-ID: <412AF360.60005@yahoo.com.au>
Date: Tue, 24 Aug 2004 17:50:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.1) Gecko/20040726 Debian/1.7.1-4
X-Accept-Language: en
MIME-Version: 1.0
To: Serban Simu <serban@asperasoft.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: page allocation failure & sk98lin
References: <412AE018.8000207@asperasoft.com>
In-Reply-To: <412AE018.8000207@asperasoft.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Serban Simu wrote:

> Hello all,
>
> I found a few references to similar problems in the list but no 
> indications of whether this has been fixed or can be avoided.
>
> I'm using 2.6.8.1 and the patch: sk98lin_v7.04_2.6.8_patch. This 
> happens  when receiving data fast on the GigE card (about 600Mbps) and 
> writing on disk. It seems to happen after writing 1 GB to disk (1024 
> MB) but I can't correlate that very reliably.
>
> I would appreciate any information pointing me to a fix or explanation.
>
> Thank you!
>
> -Serban
>
> swapper: page allocation failure. order:0, mode:0x20


The messages should be basically harmless and can't be completely avoided.

That said, -mm kernels have patches to fix up numerous problems with the 
page
allocator which have a good chance of fixing your problems.
