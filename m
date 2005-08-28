Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbVH1V4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbVH1V4i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 17:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbVH1V4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 17:56:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48544 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750876AbVH1V4h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 17:56:37 -0400
Date: Sun, 28 Aug 2005 14:55:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why is kmem_bufctl_t different across platforms?
Message-Id: <20050828145503.7b1a5f71.akpm@osdl.org>
In-Reply-To: <3B0AEB5C-4A65-413F-BD35-B9F0E0984653@mac.com>
References: <3B0AEB5C-4A65-413F-BD35-B9F0E0984653@mac.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett <mrmacman_g4@mac.com> wrote:
>
> While exploring the asm-*/types.h files, I discovered that the
>  type "kmem_bufctl_t" is differently defined across each platform,
>  sometimes as a short, and sometimes as an int.  The only file
>  where it's used is mm/slab.c, and as far as I can tell, that file
>  doesn't care at all, aside from preferring it to be a small-sized
>  type.

I don't think there's any good reason for this.  -mm's
slab-leak-detector.patch switches them all to unsigned long.
