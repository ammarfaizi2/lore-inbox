Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319458AbSILHBl>; Thu, 12 Sep 2002 03:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319460AbSILHBl>; Thu, 12 Sep 2002 03:01:41 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.10]:44294 "EHLO
	net.cc.swin.edu.au") by vger.kernel.org with ESMTP
	id <S319458AbSILHBk>; Thu, 12 Sep 2002 03:01:40 -0400
From: Tim Connors <tconnors@astro.swin.edu.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Killing/balancing processes when overcommited
In-Reply-To: <OFA28F240F.93209971-ON88256C31.005E5F03@boulder.ibm.com>
References: <OFA28F240F.93209971-ON88256C31.005E5F03@boulder.ibm.com>
X-Face: "$j_Mi4]y1OBC/&z_^bNEN.b2?Nq4#6U/FiE}PPag?w3'vo79[]J_w+gQ7}d4emsX+`'Uh*.GPj}6jr\XLj|R^AI,5On^QZm2xlEnt4Xj]Ia">r37r<@S.qQKK;Y,oKBl<1.sP8r,umBRH';vjULF^fydLBbHJ"tP?/1@iDFsKkXRq`]Jl51PWN0D0%rty(`3Jx3nYg!
Message-ID: <slrn-0.9.7.4-17161-8026-200209121703-j.$random.luser@swin.edu.au>
Date: Thu, 12 Sep 2002 17:06:27 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In linux.kernel, you wrote:
> 
>                                     resource
>      group                          priority                kill priority
>      system                         0                       0 - never kill
>      support                        1                       1
>      payroll                        2                       2
>      production                     3                       3
>      general user                   4                       4
>      production backgournd    5           3   <- make sure testing and
> general user are killed BEFORE production
>      testing                        6                       5
> 
> Note that in the example above, production has the second lowest resource
> priority, but a higher kill priority ("we don't care how long it takes, but
> it must complete").
> 
> In a system with sufficient resources, everyone would get what they needed.
> As resources become limit, payroll gets resources first and testing gets
> the least. In the extreme case, when the system is overwhelmed, testing is
> the first to be removed.

You seemed to have just described a combination of forced niceness
(from login scripts) and ulimit. Man ulimit about how to limit number
of processes plus memory etc, so people can't fork() bomb you out of
existance.

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/

Conclusion to my thesis -- 
"It is trivial to show that it is clearly obvious that this is not 
woofly"

