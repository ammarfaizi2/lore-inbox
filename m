Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbWGMLXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWGMLXU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 07:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932452AbWGMLXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 07:23:19 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:22803 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932444AbWGMLXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 07:23:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=kCXg+fQhxJQKyef1vsbrSyTBZeGxYb5Edj+CquAGxNfYezPTqGD/Ay2owiPC84qXfRLeetOD4ZcXYi0ey8SxkvuaqiHl8gnkYmuvwzigY6rayNUFaAfniM8C59dCy4kWbrt6VA0M16H7hi4FrmNXzPsWhse+r6O4DiKkail4Wj4=
Date: Thu, 13 Jul 2006 13:23:29 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: Mark Hounschell <dmarkh@cfl.rr.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Mark Hounschell <markh@compro.net>
Subject: Re: PI support for semaphores?
In-Reply-To: <44B626BB.8020907@cfl.rr.com>
Message-ID: <Pine.LNX.4.64.0607131317570.19255@localhost.localdomain>
References: <44B626BB.8020907@cfl.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 13 Jul 2006, Mark Hounschell wrote:

> Does PI support for user land semaphores exist?
>

Yes.
But please stop call them "semaphores". PI only makes sense for the kind 
of semaphores called "mutexes" (which can be just a basic semaphore).

2.6.18-rc1 and 2.6.17-rt7 (and earlier) have PI futexes.
You still need a patch to glibc. I downloaded it from
  http://people.redhat.com/mingo/PI-futex-patches/

I have tested it and it works fine (except for a small problem with 
pthread_mutex_timedlock(), which shouldn't be a problem for 95% of the 
applications :-)

Esben

> Thanks
> Mark
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
