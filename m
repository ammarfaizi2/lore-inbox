Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbVBVMIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbVBVMIx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 07:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbVBVMIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 07:08:52 -0500
Received: from one.firstfloor.org ([213.235.205.2]:28563 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262277AbVBVMIn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 07:08:43 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch -mm series] ia64 specific /dev/mem handlers
References: <16923.193.128608.607599@jaguar.mkp.net>
	<20050222020309.4289504c.akpm@osdl.org>
From: Andi Kleen <ak@muc.de>
Date: Tue, 22 Feb 2005 13:08:41 +0100
In-Reply-To: <20050222020309.4289504c.akpm@osdl.org> (Andrew Morton's
 message of "Tue, 22 Feb 2005 02:03:09 -0800")
Message-ID: <m1wtt0lrue.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:
>
> Is it possible to avoid consuming a page flag?
>
> If this is an ia64-only (or 64-bit-only) thing I guess we could use bit 32.

It's not. i386 essentially has the same problem. Other architectures
likely too. We definitely need a generic solution, especially when
we're going to support PAT on i386/x86-64 better (which I hope will
happen soon)

-Andi
