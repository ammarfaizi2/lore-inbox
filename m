Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbVKJWC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbVKJWC6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 17:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbVKJWC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 17:02:58 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:28387 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932179AbVKJWC5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 17:02:57 -0500
Subject: Re: [PATCH] poll(2) timeout values
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ulrich Drepper <drepper@gmail.com>
Cc: Peter Staubach <staubach@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <a36005b50511101049vf20cde5m9385c433e18dcd2d@mail.gmail.com>
References: <437375DE.1070603@redhat.com>
	 <1131642956.20099.39.camel@localhost.localdomain>
	 <a36005b50511101049vf20cde5m9385c433e18dcd2d@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 10 Nov 2005 22:33:42 +0000
Message-Id: <1131662022.20099.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-11-10 at 10:49 -0800, Ulrich Drepper wrote:
> On 11/10/05, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > There really is no need for the kernel API to match the userspace one,
> 
> But if in this case the argument is not changed you would have to add
> an explicit & 0xffffffff before using the parameter.  

No. The poll POSIX libc call takes an int. What the kernel ones does
with the top bits is irrelevant to applications. It is however highly
relevant to things like syscall sequences and what the syscall interface
places on the stack.

