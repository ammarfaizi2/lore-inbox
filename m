Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965078AbVINH6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbVINH6F (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 03:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbVINH6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 03:58:05 -0400
Received: from host62-24-231-115.dsl.vispa.com ([62.24.231.115]:8372 "EHLO
	orac.walrond.org") by vger.kernel.org with ESMTP id S965078AbVINH6E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 03:58:04 -0400
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Q: why _less_ performance on machine with SMP then with UP kernel ?
Date: Wed, 14 Sep 2005 08:58:02 +0100
User-Agent: KMail/1.8.2
References: <dg7fbf$5df$1@news.cistron.nl> <200509132254.15158.andrew@walrond.org> <dg8f8l$80n$1@news.cistron.nl>
In-Reply-To: <dg8f8l$80n$1@news.cistron.nl>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509140858.02951.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 September 2005 07:16, Danny ter Haar wrote:
>
> Now that you mention it, i saw this in the log file when running the SMP
> kernel:
>
> newsgate kernel: mv[7024]: segfault at 00002aaaaabc3648 rip
> 00002aaaaaaac80e rsp 00007fffffdc17c0 error 4
>
> It was only a oneliner, no further details.
>

Almost certainly due to bug 4851. You _really_ do not want to be using 2.6.12+ 
smp kernels on your hardware until this is sorted out. Stick to 2.6.11.12

I think this bug is going to bite a _lot_ of amd64 smp and dual core people as 
they/distros start upgrading to these newer kernels.

Andrew/Linus: you might consider including a warning in kernel release 
messages until this problem gets resolved, since it affects userland in such 
an unpredictable way and we have a good handle on which systems it affects 
(smp AMD64)

Andrew Walrond
