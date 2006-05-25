Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030301AbWEYSAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030301AbWEYSAq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 14:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbWEYSAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 14:00:45 -0400
Received: from lixom.net ([66.141.50.11]:20138 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S1030295AbWEYSAp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 14:00:45 -0400
Date: Thu, 25 May 2006 10:59:40 -0700
To: Chris Leech <christopher.leech@intel.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/9] [I/OAT] DMA memcpy subsystem
Message-ID: <20060525175940.GB9867@pb15.lixom.net>
References: <20060524001653.19403.31396.stgit@gitlost.site> <20060524002012.19403.50151.stgit@gitlost.site>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060524002012.19403.50151.stgit@gitlost.site>
User-Agent: Mutt/1.5.11
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, May 23, 2006 at 05:20:12PM -0700, Chris Leech wrote:

> +EXPORT_SYMBOL(dma_async_memcpy_buf_to_buf);
> +EXPORT_SYMBOL(dma_async_memcpy_buf_to_pg);
> +EXPORT_SYMBOL(dma_async_memcpy_pg_to_pg);

Is there a specific reason for why you chose to export 3 different
memcpu calls? They're all just wrapped to the same internals.

It would seem to make sense to have the client do their own
page_address(page) + offset calculations and just export one function?


-Olof

