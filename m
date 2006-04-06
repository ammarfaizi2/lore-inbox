Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWDFC4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWDFC4Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 22:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWDFC4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 22:56:24 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:57567 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751346AbWDFC4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 22:56:23 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: Respin: [PATCH] mm: limit lowmem_reserve
Date: Thu, 6 Apr 2006 12:55:54 +1000
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org
References: <200604021401.13331.kernel@kolivas.org> <200604061129.41658.kernel@kolivas.org> <20060405194344.1915b57a.akpm@osdl.org>
In-Reply-To: <20060405194344.1915b57a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604061255.55055.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 April 2006 12:43, Andrew Morton wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> > It is possible with a low enough lowmem_reserve ratio to make
> >  zone_watermark_ok fail repeatedly if the lower_zone is small enough.
>
> Is that actually a problem?

Every single call to get_page_from_freelist will call on zone reclaim. It 
seems a problem to me if every call to __alloc_pages will do that?

Cheers,
Con
