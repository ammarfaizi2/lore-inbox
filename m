Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276761AbRJaASf>; Tue, 30 Oct 2001 19:18:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275990AbRJaAS0>; Tue, 30 Oct 2001 19:18:26 -0500
Received: from mail000.mail.bellsouth.net ([205.152.58.20]:39798 "EHLO
	imf00bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S277001AbRJaASO>; Tue, 30 Oct 2001 19:18:14 -0500
Message-ID: <3BDF436A.AE664A99@mandrakesoft.com>
Date: Tue, 30 Oct 2001 19:18:50 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Kuebel <kuebelr@email.uc.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 8139too thread termination
In-Reply-To: <20011029232508.A305@cartman> <20011030191152.A898@cartman>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Kuebel wrote:
> 
> ok, i am wondering if i have made a mistake.  this patch will make the
> kernel thread die when tp->time_to_die is true.  tp is kmalloc()'ed
> inside of alloc_etherdev.  i didn't initialize time_to_die to 0, but
> this patch has been working perfectly for me.  am i just lucky or are
> kmalloc()'ed regions zero'ed out?

And here I thought you did it on purpose :)

alloc_etherdev zeroes memory it allocates, so in net drivers all private
structures can be considered initialized to zero when you get them.

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

