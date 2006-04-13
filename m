Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964973AbWDMVKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964973AbWDMVKU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 17:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbWDMVKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 17:10:20 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:64757 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964973AbWDMVKT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 17:10:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kn0Ac/WQivuREJOSb/4WSM55ZOtBmJGGwQRfrKk2JIWkY2m0R1eHP5zAQElNUm/XWSjA+5UfeuRx6agkSSbkC4qNV7bosITYWZL0Cm1pSE36Jwg7TXx8kJaC2Ctm808eE1y6K7glWN0lKC+GRYHWRLsM0HBrkUirkJa+WuQHl2g=
Message-ID: <62a080740604131410p3f22f7afncd3096c49be41cf4@mail.gmail.com>
Date: Thu, 13 Apr 2006 14:10:16 -0700
From: "K P" <kplkml@gmail.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Subject: Re: JVM performance on Linux (vs. Solaris/Windows)
Cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <443EB70B.3080908@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <62a080740604130753i4b8bbbckc3cba12092b54226@mail.gmail.com>
	 <443E74C1.5090801@mbligh.org> <443EBC1D.1000307@wolfmountaingroup.com>
	 <443EB70B.3080908@mbligh.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Besides, Specjbb_2005 doesn't do any IO or networking, and these should
not be factors in the result.

So although it's a simplistic benchmark where OS tuning may not provide as
much benefit as JVM tuning, it still doesn't explain why Solaris is ~15% higher
than Linux on the same hardware and JVM (I'm guessing that the tester did
not spend as much time tuning Linux as they did Solaris, hence the question).

-kp


On 4/13/06, Martin J. Bligh <mbligh@mbligh.org> wrote:
>
> > Note they ran the benchmark on an Opteron 285 instead of a Xeon with
> > 16 GB of memory.    Opteron peformance currently **SUCKS** with 2.6
> > series kernels under any kind of heavy I/O due to their cloning of the
> > ancient 82489DX architecture for I/O interrupt access and
> > performance.  Looks like the test was stakced against Linux from the
> > start.  Should have used a Xeon system.
> > AMD needs to get their crappy I/O performance up to snuff.  Looking at
> > the test parameteres leads me to believe there was a lot of swapping
> > on a system with already poor I/O performance.
> >
>
> Looks to me like it was the same h/w for Linux as Solaris, so I don't
> think that's much of an excuse ;-)
>
> M.
>
>
