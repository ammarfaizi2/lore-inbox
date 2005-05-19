Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVESXvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVESXvv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 19:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVESXvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 19:51:32 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:65419 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261361AbVESXvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 19:51:12 -0400
Subject: Re: [PATCH] Fixes for IPMI use of timers
From: Lee Revell <rlrevell@joe-job.com>
To: Corey Minyard <minyard@acm.org>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <428D2181.2080106@acm.org>
References: <428D2181.2080106@acm.org>
Content-Type: text/plain
Date: Thu, 19 May 2005 19:51:07 -0400
Message-Id: <1116546667.23807.0.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-19 at 18:30 -0500, Corey Minyard wrote:
>                 /* We already have irqsave on, so no need for it
>                     here. */
> -               read_lock(&xtime_lock);
> +               read_lock_irqsave(&xtime_lock, flags); 

The comment is now wrong.

Lee

