Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbTIHVMx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 17:12:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263584AbTIHVMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 17:12:53 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:56719 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S263580AbTIHVMv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 17:12:51 -0400
Date: Mon, 8 Sep 2003 22:12:34 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Hua Zhong <hzhong@cisco.com>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: THREAD_GROUP and linux thread
Message-ID: <20030908211234.GA28109@mail.jlokier.co.uk>
References: <127101c3764c$6990df80$ca41cb3f@amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <127101c3764c$6990df80$ca41cb3f@amer.cisco.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hua Zhong wrote:
> but I am just wondering if I could just change the kernel to treat
> CLONE_VM the same way as CLONE_THREAD which is a much simpler change.

No.  There are a good many programs which use CLONE_VM without
CLONE_THREAD, and I'm sure they will be surprised to find signals
suddenly being shared, which is implied by CLONE_THREAD.

> 2. Which version of pthread uses the CLONE_THREAD flag?

NPTL.

Enjoy,
-- Jamie
