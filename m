Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261813AbUBWFd4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 00:33:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbUBWFd4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 00:33:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:16557 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261813AbUBWFdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 00:33:55 -0500
Date: Sun, 22 Feb 2004 21:34:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: strosake@austin.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch-specific callout in panic()
Message-Id: <20040222213438.7682ff7b.akpm@osdl.org>
In-Reply-To: <40398BFE.1040300@austin.ibm.com>
References: <40398BFE.1040300@austin.ibm.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Strosaker <strosake@austin.ibm.com> wrote:
>
> There are some ppc64-specific actions that should be taken upon a
>  kernel panic.  Rather than adding a new #ifdef in panic(), it seems to
>  me that it would be worthwhile to add a single callout, and move the
>  arch-specific code out to the arch subtrees.  Does this seem reasonable,
>  or should another #ifdef be added in panic() to perform the ppc64-
>  specific actions?

We have the panic_notifier_list in there.  Cannot you hook into that?
