Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751580AbWHANrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751580AbWHANrE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 09:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWHANrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 09:47:03 -0400
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:18054 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751575AbWHANrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 09:47:02 -0400
Date: Tue, 1 Aug 2006 09:46:58 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>
Subject: Re: [take2 1/4] kevent: core files.
In-Reply-To: <11544248451203@2ka.mipt.ru>
Message-ID: <Pine.LNX.4.64.0608010945090.10827@d.namei>
References: <11544248451203@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2006, Evgeniy Polyakov wrote:

> +	u->ready_num = 0;
> +#ifdef CONFIG_KEVENT_USER_STAT
> +	u->wait_num = u->im_num = u->total = 0;
> +#endif

Generally, #ifdefs in the body of the kernel code are discouraged.  Can 
you abstract these out as static inlines?


- James
-- 
James Morris
<jmorris@namei.org>
