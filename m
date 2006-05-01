Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWEAV4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWEAV4M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWEAV4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:56:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11663 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932286AbWEAV4K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:56:10 -0400
Date: Mon, 1 May 2006 14:58:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH] UML - Change timer initialization
Message-Id: <20060501145837.1069e19e.akpm@osdl.org>
In-Reply-To: <200605012046.k41KkURr005868@ccure.user-mode-linux.org>
References: <200605012046.k41KkURr005868@ccure.user-mode-linux.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Dike <jdike@addtoit.com> wrote:
>
> This is definite 2.6.17 material...
> 
> As of rc3-mm1, inet_init, which schedules, is called before the UML timer_init,
> which sets up the timer.  The result is the interval timers being manipulated
> before the appropriate signal handlers are established, causing unhandled
> timers.
> 

Which means nobody's tested uml against the last couple of -mm's.  Bad.
