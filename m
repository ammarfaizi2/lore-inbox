Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261604AbVBHRiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261604AbVBHRiX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 12:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbVBHRiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 12:38:23 -0500
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33]:26032 "HELO
	smtp002.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261604AbVBHRiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 12:38:18 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: Anton Altaparmakov <aia21@cam.ac.uk>, Jeff Dike <jdike@addtoit.com>
Subject: Re: [BUG report] UML linux-2.6 latest BK doesn't compile
Date: Tue, 8 Feb 2005 18:37:22 +0100
User-Agent: KMail/1.7.2
Cc: lkml <linux-kernel@vger.kernel.org>,
       user-mode-linux-devel@lists.sourceforge.net
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk> <200502081829.j18ITAs0003968@ccure.user-mode-linux.org>
In-Reply-To: <200502081829.j18ITAs0003968@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502081837.22519.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 February 2005 19:29, Jeff Dike wrote:
> aia21@cam.ac.uk said:
> > arch/um/kernel/exec_kern.c:59: undefined reference to `__bb_init_func'
>
> The __bb_init_func export is to allow modules to be built with a
> gcov-enabled UML.  I get a bunch of undefines in the module links when I
> get rid of it.
>
> This is probably being too intimate with libc, and yours probably doesn't
> have __bb_init_func.
>
> Try the patch below and see if it helps.  Modules won't work, but you
> should get a working UML.

Why not simply disable CONFIG_GCOV for him, in this case?

Sorry for my previous answer, I was misleaded by the error message (which 
*does not* make sense). And it's the first time anybody sees a such error 
message, in my experience, so please post more details about your glibc (and 
whether gcov is installed).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

