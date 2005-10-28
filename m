Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964997AbVJ1K4T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964997AbVJ1K4T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 06:56:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965187AbVJ1K4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 06:56:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24547 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964997AbVJ1K4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 06:56:18 -0400
Date: Fri, 28 Oct 2005 03:55:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Davi Arnaut <davi.lkml@gmail.com>
Cc: greearb@candelatech.com, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com
Subject: Re: kernel BUG at mm/slab.c:1488! (2.6.13.2)
Message-Id: <20051028035537.1e5e1d2c.akpm@osdl.org>
In-Reply-To: <750c918d0510280336g67344787r66a9aba4753e22cb@mail.gmail.com>
References: <750c918d0510272032k79211b44vee825864d0f26438@mail.gmail.com>
	<20051027215312.57303595.akpm@osdl.org>
	<750c918d0510280336g67344787r66a9aba4753e22cb@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davi Arnaut <davi.lkml@gmail.com> wrote:
>
> How about really fixing kmem_cache_* to use the proper return conventions ?
>  In this case it should have returned ERR_PTR(-EEXIST);

A NULL return on failure is fine - what would we do with the additional
info anyway?  Not anything which justifies updating the >200 callsites, I
suspect.
