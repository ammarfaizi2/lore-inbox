Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932361AbWI0Dmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932361AbWI0Dmh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 23:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbWI0Dmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 23:42:37 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45957 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932361AbWI0Dmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 23:42:36 -0400
Date: Tue, 26 Sep 2006 20:42:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] UML - file renaming
Message-Id: <20060926204224.e365734f.akpm@osdl.org>
In-Reply-To: <200609261753.k8QHrGlI005530@ccure.user-mode-linux.org>
References: <200609261753.k8QHrGlI005530@ccure.user-mode-linux.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2006 13:53:15 -0400
Jeff Dike <jdike@addtoit.com> wrote:

> Move some foo_kern.c files to foo.c now that the old foo.c files are out
> of the way.

This doesn't apply, because arch/um/kernel/process_kern.c has been altered
by uml-fix-stack-alignment.patch.

I fixed that up via

	 mv arch/um/kernel/process_kern.c arch/um/kernel/skas/process_kern.c

> Also cleaned up some whitespace and an emacs formatting comment.

So if any of these changes were made to process_kern.c, you've lost 'em.

They shouldn't have been: please do code-moving and code-changing within
distinct patches.

This file-moving also moved over a bunch of trailing-whitespace, which I
removed.  Which violates the previous rule.  I'm bad.

btw, it'd be nice to change your scripts to add a diffstat after the ^---.
