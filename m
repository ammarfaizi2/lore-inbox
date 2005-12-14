Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932458AbVLNWHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbVLNWHU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbVLNWHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:07:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:25037 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932458AbVLNWHS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:07:18 -0500
Date: Wed, 14 Dec 2005 14:05:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix the EMBEDDED menu
Message-Id: <20051214140531.7614152d.akpm@osdl.org>
In-Reply-To: <20051214191006.GC23349@stusta.de>
References: <20051214191006.GC23349@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> Hi Linus,
> 
> your patch to allow CC_OPTIMIZE_FOR_SIZE even for EMBEDDED=n has broken 
> the EMBEDDED menu.

It looks like that patch needs to be reverted or altered anyway.  sparc64
machines are failing all over the place, possibly due to newly-exposed
compiler bugs.

Whether it's the compiler or it's genuine kernel bugs, the same problems
are likely to bite other architectures.
