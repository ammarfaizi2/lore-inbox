Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264870AbTFTVj3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 17:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264876AbTFTVj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 17:39:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5811 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264870AbTFTVjW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 17:39:22 -0400
Message-ID: <3EF38248.2070807@pobox.com>
Date: Fri, 20 Jun 2003 17:53:12 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: David Lang <david.lang@digitalinsight.com>, linux-kernel@vger.kernel.org,
       jmorris@intercode.com.au, davem@redhat.com,
       David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC] Breaking data compatibility with userspace bzlib
References: <20030620194517.GA22732@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0306201247560.28021-100000@dlang.diginsite.com> <20030620200554.GC22732@wohnheim.fh-wedel.de>
In-Reply-To: <20030620200554.GC22732@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> On Fri, 20 June 2003 12:48:51 -0700, David Lang wrote:
>>he is saying that the memory and CPU requirements to do the bzip
>>uncompression are so much larger then what is nessasary to do the gzip
>>uncompression that the small amount of space saved is almost never worth
>>the cost.

exactly


> just a few).  It is impossible in it's current state to use less than
> roughly 1MB of memory, even though the algorithm doesn't give that
> restriction at all.  Drop that down to 280k, the current zlib value
> and you won't see a difference in compression ratios for jffs2 at
> least.

Well, if you drop that down to 280k, and you do not beat zlib 
compression by a "comfortable margin", it's just pointless code churn in 
addition to swapping out the faster algorithm for the slower algorithm.

If you drop that down to 280k with much better compression than zlib, 
that's fantastic and useful, and people won't mind the slower algorithm :)

The issue of memory usage at high compression rates was the main reason 
why I didn't push the patch upstream and pursue bzlib further.

	Jeff



