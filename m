Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285165AbRLXRCk>; Mon, 24 Dec 2001 12:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285166AbRLXRCT>; Mon, 24 Dec 2001 12:02:19 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:65028 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S285165AbRLXRCO>; Mon, 24 Dec 2001 12:02:14 -0500
Subject: Re: [patch] Assigning syscall numbers for testing
To: dledford@redhat.com (Doug Ledford)
Date: Mon, 24 Dec 2001 17:11:40 +0000 (GMT)
Cc: kaos@ocs.com.au (Keith Owens), bcrl@redhat.com (Benjamin LaHaise),
        linux-kernel@vger.kernel.org
In-Reply-To: <3C275D4E.1010205@redhat.com> from "Doug Ledford" at Dec 24, 2001 11:52:30 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16IYdY-0004bY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, I'm not going to mess with code, but here's the example.  Say you 
> start at syscall 240 for dynamic registration.  Someone then submits a patch 

The number you start at depends on the kernel you run.

> modify the base of your patch, but if it has been accepted into any real 
> kernels anywhere, then someone could inadvertently end up running a user 
> space app compiled against Linus' new kernel and that uses the newly 
> allocated syscalls 240 and 241.  If that's run on an older kernel with your 

The code on execution will read the syscall numbers from procfs. It will
find new numbers and call those. Its a very simple implementation of lazy
binding. It only breaks if you actually run out of syscalls, and then it
fails safe.

Alan
