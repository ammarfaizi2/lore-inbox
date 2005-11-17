Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750700AbVKQIeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750700AbVKQIeO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 03:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbVKQIeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 03:34:14 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:7350 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750700AbVKQIeN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 03:34:13 -0500
Date: Thu, 17 Nov 2005 09:34:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch -rt] make gendev_rel_sem a compat_semaphore
Message-ID: <20051117083427.GA16354@elte.hu>
References: <1132155092.6266.6.camel@localhost.localdomain> <1132155299.6266.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1132155299.6266.8.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> I was getting the following:
> 
> BUG: nonzero lock count 10 at exit time?
>         modprobe: 2972 [ffff81007e1aaf70, 116]

> Looking into this I see that gendev_rel_sem, which is only used when 
> the device is unregistered, is defined as a semaphore.  This patch 
> changes this to be a compat_semaphore.

thanks, applied.

	Ingo
