Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbTJMBOt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 21:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbTJMBOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 21:14:49 -0400
Received: from fw.osdl.org ([65.172.181.6]:60595 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261304AbTJMBOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 21:14:49 -0400
Date: Sun, 12 Oct 2003 18:17:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: torvalds@osdl.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] report user-readable fixmap area in /proc/PID/maps
Message-Id: <20031012181757.6272eaf5.akpm@osdl.org>
In-Reply-To: <200310070854.h978sTsY003001@magilla.sf.frob.com>
References: <200310070854.h978sTsY003001@magilla.sf.frob.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> wrote:
>
> This patch makes /proc/PID/maps report the range from FIXADDR_USER_START to
>  FIXADDR_USER_END as a final pseudo-vma.

This special-casing, and the special-casing in get_user_pages() would go
away if each process had a real VMA for the fixmap area inserted into its
VMA tree.

Remind me again why we cannot do that?
