Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264888AbTGBJuA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 05:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264904AbTGBJuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 05:50:00 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:58629 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S264888AbTGBJt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 05:49:58 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: zwane@arm.linux.org.uk (Zwane Mwaikambo), linux-kernel@vger.kernel.org
Subject: Re: To make a function get executed on cpu2
In-Reply-To: <Pine.LNX.4.53.0307011223520.2299@montezuma.mastecende.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.21-1-686-smp (i686))
Message-Id: <E19XeSS-0008Rg-00@gondolin.me.apana.org.au>
Date: Wed, 02 Jul 2003 20:03:24 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo <zwane@arm.linux.org.uk> wrote:
> On Mon, 30 Jun 2003, Raghava Raju wrote:
> 
>> In multicpu systems in kernel version 2.4.19, how 
>> can we specify that a function be executed on 
>> a cpu of our choice(say cpu_2). Moreover if I call a
>> function from cpu_1 to be executed on cpu_2, I dont
>> want to wait in cpu_1 until complete execution of
>> function on cpu_2 . Is it possible?????
>> 
>> Any example would be really helpful. Please 
>> mail back to vraghava_raju@yahoo.com.
> 
> You can't really do it portably across all architectures, Alpha has 
> smp_call_function_on_cpu which would allow you to do this. If you're 

Surely you can emulate it using smp_call_function and make it return
straight away if it runs on the wrong CPU.
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
