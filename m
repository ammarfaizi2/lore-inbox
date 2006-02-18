Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbWBRFBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbWBRFBD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 00:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750805AbWBRFBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 00:01:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33234 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750802AbWBRFBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 00:01:01 -0500
Date: Fri, 17 Feb 2006 20:59:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: greg@kroah.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-pm@osdl.org
Subject: Re: [PATCH 1/5] [pm] Fix locking of device suspend/resume functions
Message-Id: <20060217205939.573e1d0c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.50.0602171756520.30811-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0602171756520.30811-100000@monsoon.he.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel <mochel@digitalimplant.org> wrote:
>
> This patch removes the unneeded down()/up() calls from
>  suspend_device() and resume_device(). Those functions
>  are already called under the dpm_sem, making this code
>  unconditionally deadlock in SMP kernels.

I've seen no reports of such deadlocks.  And I was testing swsusp on a
4-way this week?

