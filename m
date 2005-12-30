Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbVL3MeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbVL3MeX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 07:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751255AbVL3MeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 07:34:23 -0500
Received: from ms-smtp-01-smtplb.tampabay.rr.com ([65.32.5.131]:8391 "EHLO
	ms-smtp-01.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1751254AbVL3MeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 07:34:22 -0500
Message-ID: <43B5294C.20903@cfl.rr.com>
Date: Fri, 30 Dec 2005 07:34:20 -0500
From: Mark Hounschell <dmarkh@cfl.rr.com>
Reply-To: dmarkh@cfl.rr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dmarkh@cfl.rr.com
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: find_vma_intersection
References: <43B5146B.9090609@cfl.rr.com>
In-Reply-To: <43B5146B.9090609@cfl.rr.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hounschell wrote:
> Can someone enlighten me as to what it really means when  a user land
> shmat call, in which the virtual address is provided, fails in the
> kernel find_vma_intersection function because
> 
>   end_addr(of my SHM) is <= vma->vm_start?

Actually because its ! <= vma->vm_start.

> 
> static inline struct vm_area_struct * find_vma_intersection(struct
> mm_struct * mm, unsigned long start_addr, unsigned long end_addr)
> {
>         struct vm_area_struct * vma = find_vma(mm,start_addr);
> 
>         if (vma && end_addr <= vma->vm_start)
>                 vma = NULL;
>         return vma;
> }
> 

Thanks
Mark
