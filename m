Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265832AbUA1DMc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 22:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265836AbUA1DMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 22:12:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:21972 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265832AbUA1DMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 22:12:31 -0500
Date: Tue, 27 Jan 2004 19:10:02 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Alessandro Suardi <alessandro.suardi@oracle.com>,
       linux-kernel@vger.kernel.org, linux-acpi@intel.com
Subject: Re: 2.6.2-rc2-bk1 oopses on boot (ACPI patch)
In-Reply-To: <20040127184228.3a0b8a86.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0401271907070.10794@home.osdl.org>
References: <40171B5B.4020601@oracle.com> <20040127184228.3a0b8a86.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Jan 2004, Andrew Morton wrote:
> 
> Divide by zero.  Looks like ACPI is now passing bad values into the
> frequency change notifier.
> 
> Does this make the oops go away?

Other values will still cause divide-by-zero (any divisor in 0..9 will do 
it). Besides, we're dividing with _old_, not new, so that's the one we 
should likely check.

		Linus
