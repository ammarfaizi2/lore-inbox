Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbWHAItV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbWHAItV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 04:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbWHAItU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 04:49:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26560 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751589AbWHAItU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 04:49:20 -0400
Date: Tue, 1 Aug 2006 01:49:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com
Subject: Re: do { } while (0) question
Message-Id: <20060801014913.5eec556c.akpm@osdl.org>
In-Reply-To: <20060801082109.GB9589@osiris.boeblingen.de.ibm.com>
References: <20060801082109.GB9589@osiris.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006 10:21:09 +0200
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> Hi Andrew,
> 
> your commit e2c2770096b686b4d2456173f53cb50e01aa635c does this:
> 
> ---
> Always use do {} while (0).  Failing to do so can cause subtle compile
> failures or bugs.
> 
> -#define hotcpu_notifier(fn, pri)
> -#define register_hotcpu_notifier(nb)
> -#define unregister_hotcpu_notifier(nb)
> +#define hotcpu_notifier(fn, pri)	do { } while (0)
> +#define register_hotcpu_notifier(nb)	do { } while (0)
> +#define unregister_hotcpu_notifier(nb)	do { } while (0)

<strains brain>

Can't remember.  Maybe it's OK in this case.

Would it be too weazelly to say "because CodingStyle says to"? ;)
