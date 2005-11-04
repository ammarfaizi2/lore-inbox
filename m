Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbVKDVm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbVKDVm3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 16:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbVKDVm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 16:42:29 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:56305 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750937AbVKDVm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 16:42:28 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] powerpc: mem_init crash for sparsemem
Date: Fri, 4 Nov 2005 22:43:48 +0100
User-Agent: KMail/1.7.2
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
References: <200511041631.17237.arnd@arndb.de> <436BC20B.9070704@shadowen.org>
In-Reply-To: <436BC20B.9070704@shadowen.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200511042243.49661.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Freedag 04 November 2005 21:18, Andy Whitcroft wrote:
> Would it not make sense to use pfn_valid(), as that is not sparsemem
> specific?  Not looked at the code in question specifically, but if you
> can use section_has_mem_map() it should be equivalent:
> 
>         if (!pfn_valid(pgdat->node_start_pfn + i))
>                 continue;
> 
> Want to spin us a patch and I'll give it some general testing.

Yes, I guess pfn_valid() is the function I was looking for, thanks
for pointing that out.

Unfortunately, I don't have access to the machine over the weekend,
so I won't be able to test that until Monday.

	Arnd <><
