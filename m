Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263518AbTLSQgY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 11:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263527AbTLSQgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 11:36:24 -0500
Received: from intra.cyclades.com ([64.186.161.6]:19100 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S263518AbTLSQgU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 11:36:20 -0500
Date: Fri, 19 Dec 2003 14:22:37 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: mikem@beardog.cca.cpqcorp.net
Cc: axboe@suse.de, marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org,
       mike.miller@hp.com, scott.benesh@hp.com
Subject: Re: cciss update for 2.4.24-pre1, #3
In-Reply-To: <Pine.LNX.4.58.0312170909380.30620@beardog.cca.cpqcorp.net>
Message-ID: <Pine.LNX.4.58L.0312191422100.27571@logos.cnet>
References: <Pine.LNX.4.58.0312170909380.30620@beardog.cca.cpqcorp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 17 Dec 2003 mikem@beardog.cca.cpqcorp.net wrote:

> Sorry I forgot to send this fix in with the 2 patches I submitted
> yesterday. We found a bug in the ASIC used on the 64xx Smart Array
> controllers. When prefetching from host memory we grab an extra 750 or
> so bytes of data. If this occurs on a memory boundary the machine will crash.
> This is primarily an issue on IPF and Alpha systems although it could happen
> on other platforms. Proliant systems are not affected by this bug because
> memory is contiguous and the top 4k of memory is masked off by the system
> firmware. The solution to the problem is to disable SCSI prefetch in the
> controller firmware. This results in a performance hit on x86 during RAID1
> operations. This patch turns on prefetch for x86 based systems only.
> Please consider this patch for inclusion in the 2.4.24 kernel.
> This patch should be applied after the 2 I submitted yesterday. It will
> patch into a fresh tree with offsets.

The other two patches have been included.

Has the prefetching been tested for long? Which kernels have it enabled?

What about 2.6?
