Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265341AbUFSJpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265341AbUFSJpR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 05:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265323AbUFSJpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 05:45:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:58283 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265341AbUFSJpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 05:45:14 -0400
Date: Sat, 19 Jun 2004 02:44:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Keith Owens <kaos@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.7] bug_smp_call_function
Message-Id: <20040619024416.065f4026.akpm@osdl.org>
In-Reply-To: <5328.1087637808@kao2.melbourne.sgi.com>
References: <5328.1087637808@kao2.melbourne.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@sgi.com> wrote:
>
>  sg.c has been fixed to no longer call vfree() with interrupts disabled.
>  Change smp_call_function() from WARN_ON to BUG_ON when interrupts are
>  disabled.  It was only set to WARN_ON because of sg.c.

I prefer the WARN_ON.  It is exceedingly unlikely that the bug will cause
lockups or memory/data corruption or anything else, so why nuke the user's
box when we can trivially continue?

We'll be sent the bug report either way.
