Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266967AbRGIBqn>; Sun, 8 Jul 2001 21:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266971AbRGIBqd>; Sun, 8 Jul 2001 21:46:33 -0400
Received: from outmail1.pacificnet.net ([207.171.0.246]:12215 "EHLO
	outmail1.pacificnet.net") by vger.kernel.org with ESMTP
	id <S266967AbRGIBqT>; Sun, 8 Jul 2001 21:46:19 -0400
Message-ID: <008301c10818$ee6ddfe0$5d910404@molybdenum>
From: "Jahn Veach - Veachian64" <V64@Galaxy42.com>
To: "Keith Owens" <kaos@ocs.com.au>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <25863.994639047@kao2.melbourne.sgi.com>
Subject: Re: Unresolved symbols in 2.4.6 
Date: Sun, 8 Jul 2001 20:46:09 -0500
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jul 2001 07:37:09 -0600,
"Keith Owens" <kaos@ocs.com.au> wrote:
> That looks OK.  Just to confirm, when you did depmod -ae, did you
> include -F pointing at the 2.4.6 System.map?  If you omitted -F then it
> used /proc/ksyms on your current kernel, I suspect that this is your
> problem.  The command should be depmod -ae -F 2.4.6/System.map 2.4.6.
> You should not need to issue that command by hand, make modules_install
> does it automatically.
>
> As for why you panic when you try to mount the root file system, you
> have your SCSI driver and ide-disk as modules, not built into the
> kernel.  If the code to find and mount your root file system is in
> modules then you must use initrd, see the kernel howto.  Unless you
> have a *very* good reason to use initrd - don't.  Build the root
> drivers into the kenrel instead.

Indeed, I left out the -F. I included the necessary modules into the kernel
and successfully booted into 2.4.6. depmod -ae -F 2.4.6/System.map 2.4.6
checked out just fine and my system is now successfully running kernel
2.4.6. Thanks for all your help.


