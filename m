Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTJ2Euh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 23:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbTJ2Eug
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 23:50:36 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:37531 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261801AbTJ2Euf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 23:50:35 -0500
Date: Wed, 29 Oct 2003 04:50:32 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "odain2@mindspring.com" <odain2@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PACKET_MMAP revisited
Message-ID: <20031029045032.GA27546@mail.shareable.org>
References: <176730-2200310329491330@M2W026.mail2web.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <176730-2200310329491330@M2W026.mail2web.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

odain2@mindspring.com wrote:
> Alan Cox pointed out that the main cost of the memory copy is
> getting the data from system memory (where the NIC put it via DMA)
> into the L1 cache (DMA doesn't do any cache coherence so it can't go
> there directly).  The memory copy (presumably from L1 cache to L1
> cache) is insignificant compared to this cost and since you'll need
> to get the data into L1 cache to use it anyway, the memory copy is
> virtually free.

After the data is copied, it's likely to be written from L1 to L2 (at
least) before that position in the ring buffer is rewritten, so that's
another overhead.

-- Jamie
