Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262653AbTHZFrc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 01:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262629AbTHZFrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 01:47:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:52610 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262653AbTHZFrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 01:47:31 -0400
Date: Mon, 25 Aug 2003 22:50:11 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
Message-Id: <20030825225011.2ad47c85.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0308260123050.1912-100000@devserv.devel.redhat.com>
References: <20030825210606.5912bac4.akpm@osdl.org>
	<Pine.LNX.4.44.0308260123050.1912-100000@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@redhat.com> wrote:
>
> but if all futexes pin down one page (worst-case), then to make it really
>  safe we'll have to use a fairly low default RLIM_NRFUTEX value - which
>  will decrease the generic utility of futexes.

We could make it RLIM_NRFUTEX_PAGES: the number of pages which the
user can pin via futexes, perhaps.
