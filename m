Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268526AbUJDTff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268526AbUJDTff (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 15:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268515AbUJDTbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 15:31:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:6081 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268526AbUJDT1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 15:27:54 -0400
Date: Mon, 4 Oct 2004 12:25:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: annabellesgarden@yahoo.de, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: 2.6.9-rc3-mm2
Message-Id: <20041004122533.0a85a1ad.akpm@osdl.org>
In-Reply-To: <20041004122304.4f545f3c.akpm@osdl.org>
References: <200410041634.24937.annabellesgarden@yahoo.de>
	<20041004122304.4f545f3c.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> You're the second person who is seeing in_interrupt() returning true when
>  clearly it should not be doing so.  Ingo, did you do soemthing which might
>  have caused this?

I'm suspecting that something is causing preempt_count() to overflow into
the softirq counter.  An imbalanced preempt_disable(), for example.
