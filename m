Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbTEKIXh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 04:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbTEKIXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 04:23:37 -0400
Received: from zero.aec.at ([193.170.194.10]:25093 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261169AbTEKIXg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 04:23:36 -0400
Date: Sun, 11 May 2003 10:36:02 +0200
From: Andi Kleen <ak@muc.de>
To: William Lee Irwin III <wli@holomorphy.com>, Andi Kleen <ak@muc.de>,
       akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use correct page protection for put_dirty_page
Message-ID: <20030511083602.GA31932@averell>
References: <20030511080841.GA31266@averell> <20030511083035.GI8978@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030511083035.GI8978@holomorphy.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 11, 2003 at 10:30:35AM +0200, William Lee Irwin III wrote:
> We know which vma is involved at the callsite and what we just set its
> vma->vm_page_prot to; I suggest this patch instead.

No that won't work. On x86-64 VM_STACK_FLAGS looks at the current
thread state if it's an 32bit or 64bit process, and that's not decided
at that point yet.

-Andi
