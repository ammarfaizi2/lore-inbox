Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267855AbUG3WRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267855AbUG3WRV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 18:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267808AbUG3WRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 18:17:21 -0400
Received: from mail5.tpgi.com.au ([203.12.160.101]:63886 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S267855AbUG3WPw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 18:15:52 -0400
Subject: Re: [Patch] Per kthread freezer flags
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Peter Osterlund <petero2@telia.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <m3llh1k845.fsf@telia.com>
References: <1090999301.8316.12.camel@laptop.cunninghams>
	 <20040729190438.GA468@openzaurus.ucw.cz>
	 <1091139864.2703.24.camel@desktop.cunninghams>
	 <20040729224422.GG18623@elf.ucw.cz>  <m3llh1k845.fsf@telia.com>
Content-Type: text/plain
Message-Id: <1091225740.11580.0.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Sat, 31 Jul 2004 08:15:41 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-07-30 at 22:11, Peter Osterlund wrote:
> Yes. What about this code in the main loop in kcdrwd?
> 
> 			/* make swsusp happy with our thread */
> 			if (current->flags & PF_FREEZE)
> 				refrigerator(PF_FREEZE);
> 
> Should it still be there when the task is marked as PF_NOFREEZE?

No, it's not needed if the thread is NOFREEZE.

Regards,

Nigel

