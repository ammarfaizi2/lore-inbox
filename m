Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263199AbUELXmB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263199AbUELXmB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 19:42:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263232AbUELXmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 19:42:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:64969 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263199AbUELXl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 19:41:58 -0400
Date: Wed, 12 May 2004 16:41:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: chrisw@osdl.org, linux-kernel@vger.kernel.org, luto@myrealbox.com
Subject: Re: [PATCH 0/2] capabilities
Message-Id: <20040512164132.2d30dac2.akpm@osdl.org>
In-Reply-To: <200405112024.22097.luto@myrealbox.com>
References: <200405112024.22097.luto@myrealbox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Lutomirski <luto@myrealbox.com> wrote:
>
> This reintroduces useful capabilities.
> 

What if there are existing applications which are deliberately or
inadvertently relying upon the current behaviour?  That seems unlikely, but
the consequences are gruesome.

If I'm right in this concern, the fixed behaviour should be opt-in.  That
could be via a new prctl() thingy but I think it would be better to do it
via a kernel boot parameter.  Because long-term we should have the fixed
semantics and we should not be making people change userspace for some
transient 2.6-only kernel behaviour.

> Andrew- is this sufficiently non-scary for -mm?

Scares the shit out of me, frankly ;)

