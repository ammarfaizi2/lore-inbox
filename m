Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131466AbRDBW5V>; Mon, 2 Apr 2001 18:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131472AbRDBW5L>; Mon, 2 Apr 2001 18:57:11 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:36881 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131466AbRDBW5A>; Mon, 2 Apr 2001 18:57:00 -0400
Subject: Re: linux scheduler limitations?
To: fabio@chromium.com (Fabio Riccardi)
Date: Mon, 2 Apr 2001 23:58:45 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AC3A6C9.991472C0@chromium.com> from "Fabio Riccardi" at Mar 29, 2001 01:19:05 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kDHc-0006r2-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've found a (to me) unexplicable system behaviour when the number of
> Apache forked instances goes somewhere beyond 1050, the machine
> suddently slows down almost top a halt and becomes totally unresponsive,
> until I stop the test (SpecWeb).

Im suprised it gets that far

> Moreover the max number of processes is not even constant. If I increase
> the server load gradually then I manage to have 1500 processes running
> with no problem, but if the transition is sharp (the SpecWeb case) than
> I end-up having a lock up.

With that many servers and a sudden load you are probably causing a lot of
paging. What kernel version. And while this isnt a solution to kernel issues
take a look at thttpd instead (www.acme.com). If you have 1500 8K stacks 
thrashing in your cache you are not going to have good performance.

