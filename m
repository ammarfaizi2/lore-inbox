Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265476AbUBGMyT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 07:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265525AbUBGMyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 07:54:19 -0500
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:779 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S265476AbUBGMyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 07:54:18 -0500
Subject: Re: 2.6.2-mm1+XFS
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: johann.lombardi@free.fr
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <4024B074.4070704@free.fr>
References: <4024B074.4070704@free.fr>
Content-Type: text/plain
Message-Id: <1076158457.798.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Sat, 07 Feb 2004 13:54:18 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-02-07 at 10:31, Johann Lombardi wrote:

> XFS mounting filesystem hde5
> i_size_write() called without i_sem
> Call Trace:
> [<c013e4db>] i_size_write_check+0x5b/0x60
> 
> Howerver, the filesystem seems to be OK.
> Is it something to worry about?

It's a new debugging "feature" introduced in 2.6.2-rc-mm kernels to help
chase down some inode operations invoked without properly signaling the
i_sem semaphore (at least, that's what I understood).

