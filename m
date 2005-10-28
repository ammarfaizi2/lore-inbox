Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030250AbVJ1Qtb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030250AbVJ1Qtb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 12:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030253AbVJ1Qtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 12:49:31 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:8584 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1030252AbVJ1Qta
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 12:49:30 -0400
Subject: Re: Intel D945GNT crashes with AGP enabled
From: Marcel Holtmann <marcel@holtmann.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051028162806.GA4340@redhat.com>
References: <1130506715.5345.7.camel@blade>
	 <20051028162806.GA4340@redhat.com>
Content-Type: text/plain
Date: Fri, 28 Oct 2005 18:49:20 +0200
Message-Id: <1130518160.5372.6.camel@blade>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

>  > The problematic part is the Intel AGP module (intel_agp), because if I
>  > don't compile it the system works fine. There is an oops coming, but so
>  > far I wasn't able to get it out. Does anyone have seen this problem
>  > before and have some patches for me to try? Otherwise I need to try to
>  > get this oops message.
> 
> You never mentioned what kernel you're running.
> If it's a recent -mm, there's an AGP optimisation patch to do less
> frequent TLB flushes, which may be worth backing out.
> 
> If you're running mainline, I'm puzzled.

basically I am running mainline, but I also tried your agpgart tree and
both are having problems.

> It'd be useful to see that oops.

I am working on it and actually it is enough to just kill the X process
to crash the system. I saw parts of the oops and it seems that there are
some RCU calls in the backtrace, but this might not help at all. So it
seems that I really need that oops.

Regards

Marcel


