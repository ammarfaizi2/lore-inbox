Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262760AbTKIS52 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 13:57:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbTKIS52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 13:57:28 -0500
Received: from adsl-66-127-195-58.dsl.snfc21.pacbell.net ([66.127.195.58]:40423
	"EHLO panda.mostang.com") by vger.kernel.org with ESMTP
	id S262760AbTKIS5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 13:57:25 -0500
To: "Deepak Kumar Gupta, Noida" <dkumar@noida.hcltech.com>
Cc: linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: problem in booting HP zx6000 with stock kernel 2.5.75
References: <Q08Y.87p.3@gated-at.bofh.it>
From: David Mosberger-Tang <David.Mosberger@acm.org>
Date: 09 Nov 2003 10:57:22 -0800
In-Reply-To: <Q08Y.87p.3@gated-at.bofh.it>
Message-ID: <ugk769qsj1.fsf@panda.mostang.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sun, 09 Nov 2003 17:00:12 +0100, "Deepak Kumar Gupta, Noida" <dkumar@noida.hcltech.com> said:

  Deepak> Hello everybody I am trying to boot 2 CPU hp zx6000 machine
  Deepak> (ia64, itanium2) from STOCK kernel version 2.5.75. I have
  Deepak> followed following steps.

2.5.75?  Why such an old kernel?

  Deepak> Kindly provide me appropriate guidance.. , where am I wrong?

For a zx6000, you're better off configuring it as ZX1 system, rather
than GENERIC.  The latter should also work, but will be (slightly)
less efficient (and the kernel will be needlessly bigger).

  Deepak> I have following doubts: -

  Deepak> 1. Is it possible to build and run _stock_ kernel (not
  Deepak> redhat patched kernel, as redhat advanced distribution is
  Deepak> available on my machine) on hp zx6000 machine ?

Yes, but you do need something newer than 2.5.75.  Try 2.6.0-test9.

  Deepak> Do I need additional patches the stock kernel + ia64 patch ?

No patch is needed.  There still is a patch, but if you don't care
about the last drop of performance and/or early printk-support, you
don't need it.

BTW: The daily build-status of Linus' kernel tree can be found here:
       http://www.gelato.unsw.edu.au/kerncomp/
     You can also get know-to-be-good .config files from there.

Also, in the future you may want to use linux-ia64@vger.kernel.org for
such question, since that mailing list is focused on ia64.

	--david
