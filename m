Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbWA3JuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbWA3JuU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 04:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWA3JuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 04:50:20 -0500
Received: from cantor.suse.de ([195.135.220.2]:15515 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932183AbWA3JuR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 04:50:17 -0500
From: Andi Kleen <ak@suse.de>
To: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH RESEND] move swiotlb.h header file to asm-generic
Date: Mon, 30 Jan 2006 10:49:41 +0100
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, Jon Mason <jdmason@us.ibm.com>,
       Christoph Hellwig <hch@lst.de>, "Luck, Tony" <tony.luck@intel.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Muli Ben-Yehuda <MULI@il.ibm.com>
References: <20060130094434.GG23968@granada.merseine.nu>
In-Reply-To: <20060130094434.GG23968@granada.merseine.nu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601301049.41854.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 January 2006 10:44, Muli Ben-Yehuda wrote:
> This patch:
> 
> - creates asm-generic/swiotlb.h
> - makes it use 'enum dma_data_direction dir' rather than 'int dir'
> - updates x86-64 and IA64 to use the common swiotlb.h
> - fixes the resulting fall out (s/int dir/enum dma_data_direction dir/
>   all over the place).

Al Viro will likely flame you badly for that enum change. Apparently it 
causes some trouble in sparse. Frankly i don't see the point neither.
It just makes the code harder to read and creates a monstrosity of a patch 
and doesn't give you anything.

-Andi

>
