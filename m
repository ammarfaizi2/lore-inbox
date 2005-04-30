Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261394AbVD3UQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261394AbVD3UQh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 16:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVD3UOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 16:14:53 -0400
Received: from fire.osdl.org ([65.172.181.4]:3460 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261394AbVD3ULd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 16:11:33 -0400
Date: Sat, 30 Apr 2005 13:10:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, maneesh@in.ibm.com,
       benh@kernel.crashing.org, jk@blackdown.de
Subject: Re: Fw: [Bug 4559] New: cfq scheduler lockup: NMI oops while
 runningltp  - 20050207  on 2.6.12-rc2-mm3 with kdump enabled
Message-Id: <20050430131027.16121b8d.akpm@osdl.org>
In-Reply-To: <4273BBB4.22EA0EAB@tv-sign.ru>
References: <20050429000038.1da6f2e1.akpm@osdl.org>
	<42737D3A.ABEF2022@tv-sign.ru>
	<4273BBB4.22EA0EAB@tv-sign.ru>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> wrote:
>
> Oleg Nesterov wrote:
> > 
> > One option is to change __mod_timer() so that it would not
> > switch ->base when the timer is already running. But this
> > would be behavioural change: currently __mod_timer() guarantees
> > that the timer would be armed on the local cpu.
> 
> Is it acceptable? If yes, I'll send the patch tomorrow.
> 
> I don't see another solution.

I don't see how it could cause any harm.
