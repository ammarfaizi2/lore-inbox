Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVAWVFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVAWVFs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 16:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVAWVFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 16:05:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:46049 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261356AbVAWVFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 16:05:42 -0500
Date: Sun, 23 Jan 2005 13:05:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] core-small: Introduce CONFIG_CORE_SMALL from -tiny
Message-Id: <20050123130514.0a9656bb.akpm@osdl.org>
In-Reply-To: <20050123175204.GV12076@waste.org>
References: <1.464233479@selenic.com>
	<20050123004042.09f7f8eb.akpm@osdl.org>
	<20050123175204.GV12076@waste.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> > I wish it didn't have "core" in the name.  A little misleading.
> 
>  Well I've got another set called NET_SMALL. BASE?

BASE works, I guess.

>  > #define PID_MAX_DEFAULT (CONFIG_CORE_SMALL ? 0x1000 : 0x8000)
>  > #define UIDHASH_BITS (CONFIG_CORE_SMALL ? 3 : 8)
>  > #define FUTEX_HASHBITS (CONFIG_CORE_SMALL ? 4 : 8)
>  > etc.
> 
>  Hmm. I think we'd want a hidden config variable for this and I'm not
>  sure how well the config language allows setting an int from a bool.

config AKPM_BOOL
        bool "akpm"

config AKPM_INT
        int
        default 1 if AKPM_BOOL
        default 0 if !AKPM_BOOL

seems to do everything which it should.

>  And then it would need another name. On the whole, seems more complex
>  than what I've done.

No, it's quite simple and avoids lots of ifdeffing.
