Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262089AbREPUsW>; Wed, 16 May 2001 16:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262094AbREPUsM>; Wed, 16 May 2001 16:48:12 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:57609 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262089AbREPUr7>; Wed, 16 May 2001 16:47:59 -0400
Subject: Re: kernel2.2.x to kernel2.4.x
To: jala_74@yahoo.com (jalaja devi)
Date: Wed, 16 May 2001 21:40:42 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (Linux Kernel Maillist)
In-Reply-To: <20010516002728.29475.qmail@web13707.mail.yahoo.com> from "jalaja devi" at May 15, 2001 05:27:28 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150867-0004Cs-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I tried porting a network driver from kernel2.2.x to
> 2.4. When i tried loading the driver, it shows the
> unresolved symbols for
> copy_to_user_ret

	if(copy_to_user(...))
		return -EFAULT

> outs

	Has not gone away, your includes are wrong

> __bad_udelay

	You are using too large a udelay use mdelay
