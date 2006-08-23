Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932322AbWHWDyG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbWHWDyG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 23:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932324AbWHWDyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 23:54:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5039 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932322AbWHWDyD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 23:54:03 -0400
Date: Tue, 22 Aug 2006 20:53:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Josh Triplett <josht@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make spinlock/rwlock annotations more accurate by using
 parameters, not types
Message-Id: <20060822205359.5a06dcde.akpm@osdl.org>
In-Reply-To: <1156294298.4510.5.camel@josh-work.beaverton.ibm.com>
References: <1156294298.4510.5.camel@josh-work.beaverton.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2006 17:51:38 -0700
Josh Triplett <josht@us.ibm.com> wrote:

> The lock annotations used on spinlocks and rwlocks currently use
> __{acquires,releases}(spinlock_t) and __{acquires,releases}(rwlock_t),
> respectively.  This loses the information of which lock actually got acquired
> or released, and assumes a different type for the parameter of __acquires and
> __releases than the rest of the kernel.  While the current implementations of
> __acquires and __releases throw away their argument, this will not always
> remain the case.

It won't?  Why, what will happen?
