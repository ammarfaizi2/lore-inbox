Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264992AbSJPOTu>; Wed, 16 Oct 2002 10:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264994AbSJPOTt>; Wed, 16 Oct 2002 10:19:49 -0400
Received: from node-209-133-23-217.caravan.ru ([217.23.133.209]:35599 "EHLO
	mail.tv-sign.ru") by vger.kernel.org with ESMTP id <S264992AbSJPOTt>;
	Wed, 16 Oct 2002 10:19:49 -0400
Message-ID: <3DAD7860.6CD3DADD@tv-sign.ru>
Date: Wed, 16 Oct 2002 18:32:00 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] futex-2.5.42-A2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Does not related to this patch, but...

On Sat, 05 Oct 2002, Oleg Nesterov wrote:
>
> Ingo Molnar wrote:
> > the new lookup code first does a lightweight follow_page(), then if no
> > page is present we do the get_user_pages() thing.
> 
> What if futex placed in VM_HUGETLB area?
> Then follow_page() return garbage.

I think __pin_page(addr_in_hugetlb_area) has serious problems. 

Oleg.
