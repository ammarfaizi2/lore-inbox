Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314075AbSDQGyR>; Wed, 17 Apr 2002 02:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314077AbSDQGyQ>; Wed, 17 Apr 2002 02:54:16 -0400
Received: from [202.135.142.194] ([202.135.142.194]:50439 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S314075AbSDQGyQ>; Wed, 17 Apr 2002 02:54:16 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.8 fix for percpu area 
In-Reply-To: Your message of "Tue, 16 Apr 2002 12:57:17 +0530."
             <20020416125716.A31123@in.ibm.com> 
Date: Wed, 17 Apr 2002 16:57:44 +1000
Message-Id: <E16xjNw-0001A5-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20020416125716.A31123@in.ibm.com> you write:
> The percpu area stuff is broken in two places -
> 
> Missing stub for setup_per_cpu_areas() in the UP case
> and missing definition of __per_cpu_data attribute in percpu.h.
> Here is a patch that fixes these. Please apply.

You should be including "linux/percpu.h" which defines __per_cpu_data
for UP.

The other fix is to move the whole #ifdef __GENERIC_PER_CPU
... setup_per_cpu_areas(void) { ...#endif out from inside the #ifdef
CONFIG_SMP block (patch sent).

Thanks,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
