Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWJCQfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWJCQfU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 12:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWJCQfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 12:35:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63713 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750963AbWJCQfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 12:35:17 -0400
Date: Tue, 3 Oct 2006 09:35:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Kirill Korotaev <dev@openvz.org>, Pavel Emelianov <xemul@openvz.org>,
       Cedric Le Goater <clg@fr.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] IPC namespace core
Message-Id: <20061003093505.0bb7bb6a.akpm@osdl.org>
In-Reply-To: <1159866174.3438.66.camel@pmac.infradead.org>
References: <200610021601.k92G13mT003934@hera.kernel.org>
	<1159866174.3438.66.camel@pmac.infradead.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Oct 2006 10:02:54 +0100
David Woodhouse <dwmw2@infradead.org> wrote:

> You need to move the #include down the file by about 50 lines so it
> lands inside the existing #ifdef __KERNEL__.
> 
> All those signed-off-bys and _none_ of you managed to notice that
> <linux/kref.h> doesn't exist in the headers we export to userspace,
> despite the fact that just running 'make headers_check' would have
> shouted at you about it?
> 
> Bad hacker. No biscuit.

We'll get there ;) I'm waiting for a suitable time to merge
add-config_headers_check-option-to-automatically-run-make-headers_check.patch,
which will cause all `make allmodconfig' testers to automatically run `make
headers_check'.

But I don't think the time is right yet - a little later, when things have
settled down and when it all works nicely on multiple architectures.
