Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbVLOWCE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbVLOWCE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:02:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751140AbVLOWCE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:02:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58522 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751129AbVLOWCD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:02:03 -0500
Date: Thu, 15 Dec 2005 14:00:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-Id: <20051215140013.7d4ffd5b.akpm@osdl.org>
In-Reply-To: <20051215212447.GR23349@stusta.de>
References: <20051215212447.GR23349@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> This patch was already sent on:
> - 11 Dec 2005
> - 5 Dec 2005
> - 30 Nov 2005
> - 23 Nov 2005
> - 14 Nov 2005

Sigh.  I saw the volume of email last time and though "gee, glad I wasn't
cc'ed on that lot".

Supporting 8k stacks is a small amount of code and nobody has seen a need
to make changes in there for quite a long time.  So there's little cost to
keeping the existing code.

And the existing code is useful:

a) people can enable it to confirm that their weird crash was due to a
   stack overflow.

b) If I was going to put together a maximally-stable kernel for a
   complex server machine, I'd select 8k stacks.  We're still just too
   squeezy, and we've had too many relatively-recent overflows, and there
   are still some really deep callpaths in there.

