Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262672AbVGMOyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbVGMOyv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 10:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbVGMOyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 10:54:50 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:37466 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262672AbVGMOyt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 10:54:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OlIhYUkmZnXEvZmizMWa2WruwnObLedeFoReF2klTf6CRLIiXKs8qsHEP0yzjpLilSuxVVu0insk/taB2/g0JBwiAuHC4y/3ezGeEe+vSd6TM8APyHk1zGNMLY8921ChLKFcLNOC4Oty0zqSVl1DAYgFkZqrVoj08XYbwBCHtYg=
Message-ID: <a44ae5cd05071307546d3f8f9e@mail.gmail.com>
Date: Wed, 13 Jul 2005 09:54:10 -0500
From: Miles Lane <miles.lane@gmail.com>
Reply-To: Miles Lane <miles.lane@gmail.com>
To: Dave Airlie <airlied@gmail.com>
Subject: Re: OOPS in 2.6.13-rc1-mm1 -- EIP is at sysfs_release+0x49/0xb0
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <21d7e99705071300173ae0c39b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <a44ae5cd05070301417531fac2@mail.gmail.com>
	 <21d7e9970507070331107831c6@mail.gmail.com>
	 <1121055986.10029.9.camel@localhost.localdomain>
	 <21d7e99705071300173ae0c39b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/05, Dave Airlie <airlied@gmail.com> wrote:
> > Thanks Dave,
> >
> > I switched to the i915 kernel driver and still got the OOPS.
> > I also continue to get the overlapping mtrr message.  I am currently
> > testing 2.6.13-rc2-git3.  I have tried to run strace with hald, but
> > cannot reproduce the problem this way.  I am not sure I am invoking the
> > command corrently.  I have written to the hal developers, but have not
> > received a response yet.  Here's the current output:
> >
> 
> Can you try and see if you apply the patch from
> 
> http://lkml.org/lkml/2005/7/8/257
> 
> It should apply to your kernel.. I cannot get this to happen on my
> system... the mtrr overlaps are just vesafb setting up the mtrrs, you
> might try without vesafb...

I will try booting without vesafb enabled.

I get an error building with the patch applied to 2.6.13-rc2-git3:

arch/i386/kernel/built-in.o(.text+0x4010): In function `die':
arch/i386/kernel/traps.c:343: undefined reference to `last_sysfs_name'
make: *** [.tmp_vmlinux1] Error 1

Thanks,
         Miles
