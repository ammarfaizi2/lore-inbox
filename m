Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbTKSCNL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 21:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263823AbTKSCNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 21:13:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:59266 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263807AbTKSCNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 21:13:10 -0500
Date: Tue, 18 Nov 2003 18:12:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
In-Reply-To: <p734qx7rmyf.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.44.0311181812080.23026-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 14 Nov 2003, Andi Kleen wrote:
> 
> That would be buggy because existing users of sendfile don't know
> about this and would silently only copy part of the file when a signal
> happens.

Don't be silly.

Existing sendfile users had _better_ accept short writes.

They happen all the time. If the destination is the network, it _will_ be 
interruptible.

		Linus

