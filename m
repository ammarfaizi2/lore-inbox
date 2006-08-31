Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWHaVjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWHaVjr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 17:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWHaVjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 17:39:46 -0400
Received: from gw.goop.org ([64.81.55.164]:39884 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932195AbWHaVjq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 17:39:46 -0400
Message-ID: <44F7571C.70806@goop.org>
Date: Thu, 31 Aug 2006 14:39:40 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Ian Campbell <Ian.Campbell@XenSource.com>
CC: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 7/8] Implement smp_processor_id() with the PDA.
References: <20060830235201.106319215@goop.org>	 <20060831000515.338336117@goop.org>	 <1157027758.12949.327.camel@localhost.localdomain>	 <44F73429.9060101@goop.org> <1157060091.25220.7.camel@localhost.localdomain>
In-Reply-To: <1157060091.25220.7.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Campbell wrote:
> Are you sure that works? When I tried it didn't. I think because
> asm/smp.h isn't included by linux/smp.h for !SMP.
>   

Nah, testing is overrated.

> I needed the below to make it work, but including linux/smp.h and
> asm/smp.h in the same file smells a bit fishy to me... Probably
> acceptable for now if you are thinking of redoing SMP processor bringup
> anyway.
>   

That looks OK for now.  Rearranging CPU bringup looks a little bit 
complex to do immediately, so this seems like a reasonable fix for now.

    J
