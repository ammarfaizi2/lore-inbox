Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262885AbTDNJDF (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 05:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262886AbTDNJDF (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 05:03:05 -0400
Received: from [12.47.58.203] ([12.47.58.203]:15724 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262885AbTDNJDE (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 05:03:04 -0400
Date: Mon, 14 Apr 2003 02:14:48 -0700
From: Andrew Morton <akpm@digeo.com>
To: maneesh@in.ibm.com
Cc: dipankar@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] dentry_stat fix
Message-Id: <20030414021448.08ff05a5.akpm@digeo.com>
In-Reply-To: <20030414144417.A27092@in.ibm.com>
References: <20030414144417.A27092@in.ibm.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Apr 2003 09:14:48.0466 (UTC) FILETIME=[4C304F20:01C30266]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh Soni <maneesh@in.ibm.com> wrote:
>
> This patch the corrects the dentry_stat.nr_unused calculation.

OK, I didn't even know we had a bug in there...

btw, can you explain to me why shrink_dcache_anon() and select_parent() are
putting dentries at the wrong end of dentry_unused?

Do these dentries have DCACHE_REFERENCED set?

Why shouldn't they get a full two rounds of aging?

It is not clear what's going on in there.  Thanks.
