Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966709AbWKOIzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966709AbWKOIzj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 03:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966708AbWKOIzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 03:55:39 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:52459 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S966709AbWKOIzi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 03:55:38 -0500
Subject: Re: Patch to fixe Data Acess error in dup_fd
From: Sharyathi Nagesh <sharyath@in.ibm.com>
Reply-To: sharyath@in.ibm.com
To: Vadim Lobanov <vlobanov@speakeasy.net>
Cc: wangzyu@cn.ibm.com, Sergey Vlasov <vsu@altlinux.ru>,
       Pavel Emelianov <xemul@sw.ru>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1163578540.4987.7.camel@localhost.localdomain>
References: <1163151121.3539.15.camel@legolas.in.ibm.com>
	 <20061114181656.6328e51a.vsu@altlinux.ru>
	 <1163530154.4871.14.camel@impinj-lt-0046>
	 <20061114204236.GA10840@procyon.home>
	 <1163540156.5412.9.camel@impinj-lt-0046>
	 <1163576300.8208.14.camel@legolas.in.ibm.com>
	 <1163578540.4987.7.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM
Date: Wed, 15 Nov 2006 14:33:16 +0530
Message-Id: <1163581396.8208.19.camel@legolas.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-15 at 00:15 -0800, Vadim Lobanov wrote:
> On Wed, 2006-11-15 at 13:08 +0530, Sharyathi Nagesh wrote:
> >    This is very interesting: after reading through I am feeling there is high chance this 
> > could as well be a memory corruption issue. But if the issue is memory getting corrupted 
> > what could be the possible reasons.
> >    I had observed random slab corruption issues in the machine, could
> > that may have resulted in corruption, we may be opening up larger issues
> > here about which I am not much aware of, 
> 
> I'm guessing that you've already tried this, but it never hurts to be
> sure: does this machine pass memtest? :)
Haven't run memtest will run and check if the problem gets recreated.

> >    The kernel version on which it is tested is: 2.6.18-1 (Distro   
> >    variant)
> 
> Unless someone recognizes special magic values from the register dumps
> to point at any particular part of the kernel, the corruption could be
> coming from almost anywhere. If noone has any better guesses, then
> narrowing down the problem might be worthwhile: grab a vanilla
> non-distro 2.6.18-1 kernel (from kernel.org) and see if you can
> reproduce the problem with that, and then try to find the previous
> release where the problem disappears. Or use git instead, which folks
> say can do this bisection process rather well. :)
> 
> Thanks,
> -- Vadim Lobanov
> 

