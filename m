Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965227AbWEOVJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965227AbWEOVJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 17:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965229AbWEOVJ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 17:09:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27582 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965227AbWEOVJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 17:09:56 -0400
Date: Mon, 15 May 2006 14:12:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bernhard Rosenkraenzer <bero@arklinux.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [FIXED] Re: Total machine lockup w/ current kernels while
 installing from CD
Message-Id: <20060515141226.794f3b7f.akpm@osdl.org>
In-Reply-To: <200605152253.02638.bero@arklinux.org>
References: <200605110322.14774.bero@arklinux.org>
	<200605152232.04304.bero@arklinux.org>
	<20060515134537.78e117dc.akpm@osdl.org>
	<200605152253.02638.bero@arklinux.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernhard Rosenkraenzer <bero@arklinux.org> wrote:
>
> On Monday, 15. May 2006 22:45, Andrew Morton wrote:
> > It's odd that we'll run initrds in a !SYSTEM_RUNNING state.
> 
> True, especially because we run initramfs in SYSTEM_RUNNING state.
> 
> > It's not an oops - it's sort-of a warning.  Did the system actually
> > continue to run and boot up OK?
> 
> No, it was a lockup and the system just hung at the point forever, so the 
> lockup detection was right.

This is odd.  Your machine hangs if cond_resched() is a no-op.  This should
not happen.

What does `grep PREEMPT .config' say?

