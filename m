Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262917AbUCWXrh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 18:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262922AbUCWXrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 18:47:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:37313 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262917AbUCWXrb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 18:47:31 -0500
Date: Tue, 23 Mar 2004 15:49:37 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kurt Garloff <garloff@suse.de>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: Non-Exec stack patches
Message-Id: <20040323154937.1f0dc500.akpm@osdl.org>
In-Reply-To: <20040323231256.GP4677@tpkurt.garloff.de>
References: <20040323231256.GP4677@tpkurt.garloff.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Garloff <garloff@suse.de> wrote:
>
> find attached a patch to parse the elf binaries for a PT_GNU_STACK
> section to set the stack non-executable if possible.

This patch propagates the PT_GNU_STACK setting into the vma flags, allowing
the architecture to set the stack permissions non-executable if the
architecture chooses to do that, yes?

Which architectures are currently making their pre-page execute permissions
depend upon VM_EXEC?  Would additional arch patches be needed for this?

This may not get past Linus of course.  It doesn't even get past me with
that magical undocumented -1/0/+1 value of the executable_stack argument. 
Please replace that with a proper, commented, #defined-or-enumerated value,
thanks.

