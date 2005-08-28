Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbVH1AlX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbVH1AlX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 20:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbVH1AlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 20:41:23 -0400
Received: from ozlabs.org ([203.10.76.45]:17872 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751002AbVH1AlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 20:41:22 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17169.2104.22407.357236@cargo.ozlabs.ibm.com>
Date: Sun, 28 Aug 2005 10:41:28 +1000
From: Paul Mackerras <paulus@samba.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: torvalds@osdl.org, akpm@osdl.org, dwmw2@redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove race between con_open and con_close
In-Reply-To: <20050828005813.A24838@flint.arm.linux.org.uk>
References: <17168.63953.95070.579096@cargo.ozlabs.ibm.com>
	<20050828005813.A24838@flint.arm.linux.org.uk>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:

> Have you looked at how serial_core handles this kind of problem in
> its open and close methods?  I put some comments in there because
> of the issue, after thinking about it fairly carefully.

Yes, albeit briefly; the problem in con_open is much simpler because
we never need to block.

Paul.
