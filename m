Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266528AbUAWHYg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 02:24:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266529AbUAWHYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 02:24:36 -0500
Received: from pizda.ninka.net ([216.101.162.242]:13231 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S266528AbUAWHYf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 02:24:35 -0500
Date: Thu, 22 Jan 2004 23:16:06 -0800
From: "David S. Miller" <davem@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Simplify net/flow.c
Message-Id: <20040122231606.7291def7.davem@redhat.com>
In-Reply-To: <20040122195104.31cc2496.akpm@osdl.org>
References: <20040122082303.3B1BC2C18C@lists.samba.org>
	<20040122101028.0eab2774.davem@redhat.com>
	<20040122195104.31cc2496.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jan 2004 19:51:04 -0800
Andrew Morton <akpm@osdl.org> wrote:

> "David S. Miller" <davem@redhat.com> wrote:
> >
> > So I'm applying this now, thanks Rusty.
> 
> It doesn't link if CONFIG_SMP=n.  semaphore `cpucontrol', used in
> flow_cache_flush() is defined in kernel/cpu.c which is not included in
> uniprocessor builds.
> 
> Here's one possible fix.

Crap, please push this to Linus if he takes the networking update I sent
him earlier today.

Thanks for catching this Andrew.
