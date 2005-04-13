Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbVDMCFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVDMCFj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 22:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263059AbVDMCCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 22:02:51 -0400
Received: from fire.osdl.org ([65.172.181.4]:27063 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263058AbVDMCBy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 22:01:54 -0400
Date: Tue, 12 Apr 2005 19:01:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: joe.korty@ccur.com
Cc: linux-kernel@vger.kernel.org, robustmutexes@lists.osdl.org
Subject: Re: [PATCH] add EOWNERDEAD and ENOTRECOVERABLE
Message-Id: <20050412190138.06a2021f.akpm@osdl.org>
In-Reply-To: <20050412152318.GA2714@tsunami.ccur.com>
References: <20050412152318.GA2714@tsunami.ccur.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty <joe.korty@ccur.com> wrote:
>
>   This patch adds EOWNERDEAD and ENOTRECOVERABLE to all
>  architectures.  Though there is nothing in the kernel
>  that uses them yet, I know of two patches in development,
>  one by Intel and the other by Bull, that adds robust mutex
>  support to pthread_mutex*.

We normally have objections to reserving parts of the name/number space for
external patches, but I think robust mutexes are sufficiently popular and
important to justify us making your lives easier.

Could you please reissue the patch, only add

/* For robust mutexes */

in the appropriate places?  Otherwise someone will come in and try to clean
it up again.
