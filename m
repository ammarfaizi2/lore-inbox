Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269337AbUJKXX5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269337AbUJKXX5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 19:23:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269352AbUJKXX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 19:23:57 -0400
Received: from fw.osdl.org ([65.172.181.6]:26575 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269337AbUJKXXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 19:23:42 -0400
Date: Mon, 11 Oct 2004 16:27:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: joshk@triplehelix.org (Joshua Kwan)
Cc: roland@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Weirdness with suspending jobs in 2.6.9-rc3
Message-Id: <20041011162717.7161b340.akpm@osdl.org>
In-Reply-To: <20041010211507.GB3316@triplehelix.org>
References: <20041005063324.GA7445@darjeeling.triplehelix.org>
	<20041009101552.GA3727@stusta.de>
	<20041009140551.58fce532.akpm@osdl.org>
	<pan.2004.10.10.07.39.54.154306@triplehelix.org>
	<20041010004524.0bf6d42e.akpm@osdl.org>
	<20041010211507.GB3316@triplehelix.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

joshk@triplehelix.org (Joshua Kwan) wrote:
>
> On Sun, Oct 10, 2004 at 12:45:24AM -0700, Andrew Morton wrote:
> > Useful, thanks.
> 
> Maybe this is useful too?
> 
> Started make on that test Makefile, and
> 
> % strace -p 31810
> Process 31810 attached - interrupt to quit
> wait4(-1073750280, NULL, 0, NULL)       = -1 ECHILD (No child processes)

Are you able to strace the same workload on an earlier kernel and work out
whether `make' is still passing in a funny PID and if so, what the kernel's
response is?


> it then immediately proceeded to give the old 'no child processes.
> Stop.' thing.
> 
> Strangely, the bug is experienced only sporadically when using make -j2
> on a kbuild. Maybe that's just a coincidence.
