Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964993AbVINEA2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964993AbVINEA2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 00:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932585AbVINEA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 00:00:27 -0400
Received: from nproxy.gmail.com ([64.233.182.192]:9710 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932584AbVINEA1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 00:00:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CCfXy8oOTZudm9Nj1Mu6hUNOxaScjHv9duQKHBkmhNBjj5u1Vv6tIDyPzj/qTakE8ICgFGPzvLZQNcGfOO9s/a3TUMWwoMvX5v8uCn5BDsJCqHFYGPek7GjwKEQC7vn5cA8FM2Ceq3Uqn3L1bow+Rz+b32qBl3VDTMdqGPBp6n4=
Message-ID: <2cd57c9005091321006825540@mail.gmail.com>
Date: Wed, 14 Sep 2005 12:00:23 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
Reply-To: coywolf@gmail.com
To: markh@compro.net
Subject: Re: HZ question
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4326CAB3.6020109@compro.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4326CAB3.6020109@compro.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/05, Mark Hounschell <markh@compro.net> wrote:
> I need to know the kernels value of HZ in a userland app.
> 
> getconf CLK_TCK
>       and
> hz = sysconf (_SC_CLK_TCK)
> 
> both seem to return CLOCKS_PER_SEC which is defined as USER_HZ which is
> defined as 100.
> 
> include/asm/param.h:
> 
> #ifdef __KERNEL__
> # define HZ       1000   /* Internal kernel timer frequency */
> # define USER_HZ  100    /* .. some user interfaces are in "ticks" */
> # define CLOCKS_PER_SEC  (USER_HZ)       /* like times() */
> #endif
> 
> Thanks in advance for any help
> Mark

simply zgrep HZ= /proc/config.gz
on my box, I get CONFIG_HZ=1000
-- 
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
