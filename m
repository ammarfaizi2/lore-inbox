Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbVLHIhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbVLHIhQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 03:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbVLHIhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 03:37:15 -0500
Received: from colin.muc.de ([193.149.48.1]:270 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S1750785AbVLHIhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 03:37:14 -0500
Date: 8 Dec 2005 09:37:09 +0100
Date: Thu, 8 Dec 2005 09:37:09 +0100
From: Andi Kleen <ak@muc.de>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>, len.brown@intel.com
Subject: Re: [PATCH] x86_64: acpi map table fix
Message-ID: <20051208083709.GA87750@muc.de>
References: <20051208041509.GA4841@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051208041509.GA4841@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2005 at 09:45:09AM +0530, Vivek Goyal wrote:
> 
> 
> o Memory till end_pfn_map has been directly mapped. So all the memory
>   references to the last page (represented by end_pfn_map) should be
>   valid.
> 
I think the correct test is

    if (phys_addr+size <= (end_pfn_map << PAGE_SHIFT) + PAGE_SIZE)
                return __va(phys_addr);


I changed it to that. Thanks.

-Andi
