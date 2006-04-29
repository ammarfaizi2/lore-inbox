Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbWD2PJb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbWD2PJb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Apr 2006 11:09:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWD2PJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Apr 2006 11:09:31 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:481 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1750740AbWD2PJa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Apr 2006 11:09:30 -0400
Date: Sun, 30 Apr 2006 00:10:03 +0900 (JST)
Message-Id: <20060430.001003.52129547.anemo@mba.ocn.ne.jp>
To: akpm@osdl.org
Cc: a.zummo@towertech.it, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RTC: rtc-dev UIE emulation
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20060428232306.5049c30d.akpm@osdl.org>
	<20060429093108.77ced705@inspiron>
References: <20060429.011648.25910123.anemo@mba.ocn.ne.jp>
	<20060428232306.5049c30d.akpm@osdl.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your detailed review, Andrew.  Basically I just merged
genrtc's stuff, but obviously it seems there are lots of things to
fix/refine/improve.  I'll try to do but it will take some times.

Alessandro, following comments are against for this patch, right?

On Sat, 29 Apr 2006 09:31:08 +0200, Alessandro Zummo <alessandro.zummo@towertech.it> wrote:
>   this patch will conflict with rtc drivers that have proper UIE
>  support, please remove it from the tree.
> 
>   A generic UIE emulation should at least check if the ioctl
>  has not been already handled by the underlaying rtc driver.
> 
>   That means that every driver should be modified to return
>  -ENOIOCTLCMD if it gets passed an unknown IOCTL and that
>  this patch should check for this code before trying to emulate.

Since rtc_dev_ioctl() calls underlaying rtc driver's ioctl() first and
checks -EINVAL, so I think it will not conflict.  Is it wrong?

---
Atsushi Nemoto
