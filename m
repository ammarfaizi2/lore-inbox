Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbVDEUIF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbVDEUIF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 16:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVDEUFP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 16:05:15 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:51427 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261964AbVDEUAS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 16:00:18 -0400
Subject: Re: [BOOTMEM] bad physical address convertions.
From: Dave Hansen <haveblue@us.ibm.com>
To: franck.bui-huu@innova-card.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <425240A2.6020504@innova-card.com>
References: <425240A2.6020504@innova-card.com>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 13:00:09 -0700
Message-Id: <1112731209.19430.135.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-05 at 09:39 +0200, Franck Bui-Huu wrote:
> Unfortunately there are some places in linux where this is not the case.
> "bootmem.c" is one of these places. For instance, it does "addr >> 
> PAGE_SHIFT"
> instead of using "phys_to_pfn" macro in order to convert a physical 
> address into a page
> frame number.
> 
> Are there any interests for a patch which will fix that ?

Probably not.

I suggest using something like discontigmem (or even sparsemem for that
matter) to properly handles holes in your address space.

-- Dave

