Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265681AbTGDCLm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 22:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265676AbTGDCK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 22:10:58 -0400
Received: from air-2.osdl.org ([65.172.181.6]:65433 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265651AbTGDCJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 22:09:56 -0400
Date: Thu, 3 Jul 2003 19:24:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <trivial@rustcorp.com.au>
Subject: Re: [PATCH] kstat_this_cpu in terms of __get_cpu_var and use it
In-Reply-To: <20030704015516.814DC2C08C@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0307031923230.3664-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Jul 2003, Rusty Russell wrote:
> 
> kstat_this_cpu() is defined in terms of per_cpu instead of __get_cpu_var.
> This patch changes that, and uses it where appropriate.

This makes some things much slower, since we'll re-compute the cpu number 
over and over and over again.

This per-cpu'ification has to stop if it just makes code slower.

		Linus

