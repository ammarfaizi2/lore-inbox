Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262266AbVCBLYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVCBLYl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 06:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbVCBLYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 06:24:41 -0500
Received: from fire.osdl.org ([65.172.181.4]:53449 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262266AbVCBLYk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 06:24:40 -0500
Date: Wed, 2 Mar 2005 03:24:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Vincent Vanackere <vincent.vanackere@gmail.com>
Cc: keenanpepper@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Undefined symbols in 2.6.11-rc5-mm1
Message-Id: <20050302032414.13604e41.akpm@osdl.org>
In-Reply-To: <65258a58050302014546011988@mail.gmail.com>
References: <422550FC.9090906@gmail.com>
	<20050302012331.746bf9cb.akpm@osdl.org>
	<65258a58050302014546011988@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Vanackere <vincent.vanackere@gmail.com> wrote:
>
> I have the exact same problem. 
>  .config is attached
>  (this may be a debian specific problem as I'm running debian too)

OK, there are no vmlinux references to lib/parser.o's symbols.  So it isn't
getting linked in.

In lib/Makefile, remove parser.o from the lib-y: rule and add

obj-y	+= parser.o


