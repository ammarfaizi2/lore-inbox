Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbWEREEY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbWEREEY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 00:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWEREEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 00:04:24 -0400
Received: from [213.184.169.214] ([213.184.169.214]:14865 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1751052AbWEREEX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 00:04:23 -0400
From: Al Boldi <a1426z@gawab.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Regression seen for patch "sched:dont decrease idle sleep avg"
Date: Thu, 18 May 2006 07:01:47 +0300
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605180701.47162.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> How's this look?
> ---
> The relationship between INTERACTIVE_SLEEP and the ceiling is not perfect
> and not explicit enough. The sleep boost is not supposed to be any larger
> than without this code and the comment is not clear enough about what
> exactly it does, just the reason it does it.
>
> There is a ceiling to the priority beyond which tasks that only ever sleep
> for very long periods cannot surpass.
>
> Opportunity to micro-optimise and re-use the ceiling variable.
>
> Signed-off-by: Con Kolivas <kernel@kolivas.org>
>
> ---
>  kernel/sched.c |   28 +++++++++++-----------------
>  1 files changed, 11 insertions(+), 17 deletions(-)
>
> Index: linux-2.6.17-rc4-mm1/kernel/sched.c
> ===================================================================
> --- linux-2.6.17-rc4-mm1.orig/kernel/sched.c    2006-05-17 15:57:49
> +++ linux-2.6.17-rc4-mm1/kernel/sched.c 2006-05-17 18:19:29

Can you post a patch against 2.6.16?

Thanks!

--
Al

