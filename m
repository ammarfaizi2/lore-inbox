Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933782AbWKSXtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933782AbWKSXtK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 18:49:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933785AbWKSXtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 18:49:10 -0500
Received: from mx0.towertech.it ([213.215.222.73]:57271 "HELO mx0.towertech.it")
	by vger.kernel.org with SMTP id S933782AbWKSXtI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 18:49:08 -0500
Date: Mon, 20 Nov 2006 00:49:03 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [patch 2.6.19-rc6] rtc class locking bugfixes
Message-ID: <20061120004903.00d48a72@inspiron>
In-Reply-To: <200611162327.37306.david-b@pacbell.net>
References: <200611162327.37306.david-b@pacbell.net>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006 23:27:37 -0800
David Brownell <david-b@pacbell.net> wrote:

> I got a lockdep warning when running "rtctest" so I though it'd be good
> to see what was up.
> 
>  - The warning was for rtc->irq_task_lock, gotten from rtc_update_irq()
>    by irq handlerss ... but in a handful of other cases, grabbed without
>    blocking IRQs.
> 
>  - Some callers to rtc_update_irq() were not ensuring IRQs were blocked,
>    yet the routine expects that; make sure all callers block IRQs.
> 
> It would appear that RTC API tests haven't been part of anyone's kernel
> regression test suite recently, at least not with lockdep running.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

 Acked-by: Alessandro Zummo <a.zummo@towertech.it>

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

