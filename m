Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289339AbSBOIv1>; Fri, 15 Feb 2002 03:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292017AbSBOIvR>; Fri, 15 Feb 2002 03:51:17 -0500
Received: from mx2.elte.hu ([157.181.151.9]:11222 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289339AbSBOIvE>;
	Fri, 15 Feb 2002 03:51:04 -0500
Date: Fri, 15 Feb 2002 11:48:55 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: kravetz <kravetz@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: bug/code cleanup for O(1)-K3
In-Reply-To: <20020214092746.A1195@w-mikek2.des.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.33.0202151148270.4847-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 14 Feb 2002, kravetz wrote:

>         if (busiest->nr_running <= this_rq->nr_running + 1)
>                 goto out_unlock;
>
>
> In the last if statement above, I suspect we want to compare
> 'busiest->nr_running' to the local variable nr_running (as was done in
> previous versions of the code). [...]

indeed we want to do that. I've added your fix to my tree.

	Ingo

