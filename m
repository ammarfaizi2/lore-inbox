Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266548AbUGKKEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266548AbUGKKEO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 06:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266546AbUGKKEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 06:04:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:50638 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266545AbUGKKEM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 06:04:12 -0400
Date: Sun, 11 Jul 2004 03:02:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: davidm@hpl.hp.com, suresh.b.siddha@intel.com, jun.nakajima@intel.com,
       torvalds@osdl.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: serious performance regression due to NX patch
Message-Id: <20040711030225.11fb61e7.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0407110550340.4229@devserv.devel.redhat.com>
References: <200407100528.i6A5SF8h020094@napali.hpl.hp.com>
	<Pine.LNX.4.58.0407110437310.26065@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0407110536130.2248@devserv.devel.redhat.com>
	<Pine.LNX.4.58.0407110550340.4229@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@redhat.com> wrote:
>
> +#ifdef __i386_

You'll be wanting __i386__ there.

Apropos of nothing much, CONFIG_X86 would be preferreed here, but x86_64
defines that too.

Is there a CONFIG symbol which is unique to i386?  If not, perhaps we
should define one (CONFIG_I386?)
