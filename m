Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262414AbVHCTUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262414AbVHCTUQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 15:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbVHCTUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 15:20:15 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:21227 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262414AbVHCTUN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 15:20:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=naoZf04wyBqS+k2uLIY0kP0cJi6JgH1T3wxjucxdk/mwkbkYR8A1BRxZyKYI9RBNEmiHQkrWSyxvF8YE/rt9Zl382CUOEpvRONm28jGW8ncnjAtbk/aqI8tjwyQzjGaTbYYE5JgO9SrSlUHmMyxbcvYrO7Cuf2r87b1csnujmV4=
Message-ID: <3afbacad05080312201d388f8e@mail.gmail.com>
Date: Wed, 3 Aug 2005 21:20:13 +0200
From: Jim MacBaine <jmacbaine@gmail.com>
Reply-To: Jim MacBaine <jmacbaine@gmail.com>
To: Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com
In-Reply-To: <200508031559.24704.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200508031559.24704.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/3/05, Con Kolivas <kernel@kolivas.org> wrote:

> This is the dynamic ticks patch for i386 as written by Tony Lindgen
> <tony@atomide.com> and Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>.
> Patch for 2.6.13-rc5
> 
> There were a couple of things that I wanted to change so here is an updated
> version. This code should have stabilised enough for general testing now.

Runs very well here on a (noname) laptop, even with apic timer, the
desktop does not "feel" different from static 1000HZ.  But dtck
reproducibly breaks software-suspend2; the kernel will simply stall on
resume.  Also stalls with dyntick=noapic.  As soon as I set
CONFIG_NO_IDLE_HZ = n, resume works again.

My kernel is 2.6.13-rc5 + swsusp-2.1.9.11 + dtck-3, the system is a
Mitac 8375 laptop, via chipset, mobile athlon xp, gcc-3.4.4

Regards,
Jim
