Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262707AbUJ1B6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262707AbUJ1B6b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 21:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262693AbUJ1B6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 21:58:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:47253 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262683AbUJ1B6U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 21:58:20 -0400
Date: Wed, 27 Oct 2004 18:56:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] error out on execve with no binfmts
Message-Id: <20041027185617.3b44eb6a.akpm@osdl.org>
In-Reply-To: <20041027184339.M2357@build.pdx.osdl.net>
References: <20041027184339.M2357@build.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
>
> Early calls to userspace can invoke an execve() before any binfmt handlers
> are registered.  Properly return an error in this case rather than 0.
> On at least one arch (x86_64) without this patch, the system will double
> fault on early attempts to call_usermodehelper.  Suggestions on a better
> error?

These handlers are installed at core_initcall() time.  Who is calling out
to userspace so early?

