Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751535AbWEKE5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbWEKE5u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 00:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWEKE5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 00:57:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40325 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751524AbWEKE5t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 00:57:49 -0400
Date: Wed, 10 May 2006 21:48:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: Latchesar Ionkov <lucho@ionkov.net>
Cc: linux-kernel@vger.kernel.org, Eric Van Hensbergen <ericvh@ericvh.myip.org>
Subject: Re: [PATCH] v9fs: signal handling fixes
Message-Id: <20060510214841.17553cfe.akpm@osdl.org>
In-Reply-To: <20060506191726.GB8063@ionkov.net>
References: <20060506191726.GB8063@ionkov.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Latchesar Ionkov <lucho@ionkov.net> wrote:
>
> +	clear_thread_flag(TIF_SIGPENDING);

It is unusual and arguably inappropriate for a filesystem to be playing
with thread flags in this manner.

There are no comments in there explaining why this is happening (there
should be: unusual and surprising things should always be commented, no?)
so I must ask on a mailing list.

What's going on in there?
