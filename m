Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310363AbSCGPc5>; Thu, 7 Mar 2002 10:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310359AbSCGPcs>; Thu, 7 Mar 2002 10:32:48 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:7362 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S310363AbSCGPcc>;
	Thu, 7 Mar 2002 10:32:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: arjanv@redhat.com, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: furwocks: Fast Userspace Read/Write Locks
Date: Thu, 7 Mar 2002 10:33:32 -0500
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16iwkE-000216-00@wagner.rustcorp.com.au> <3C8761FF.A10E50D9@redhat.com>
In-Reply-To: <3C8761FF.A10E50D9@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020307153228.3A6773FE06@smtp.linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 March 2002 07:50 am, Arjan van de Ven wrote:
> Rusty Russell wrote:
> > This is a userspace implementation of rwlocks on top of futexes.
>
> question: if rwlocks aren't actually slower in the fast path than
> futexes,
> would it make sense to only do the rw variant and in some userspace
> layer
> map "traditional" semaphores to write locks ?
> Saves half the implementation and testing....
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I m not in favor of that. The dominant lock will be mutexes.
-- 
-- Hubertus Franke  (frankeh@watson.ibm.com)
