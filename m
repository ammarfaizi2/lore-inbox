Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbTEMNcF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 09:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbTEMNcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 09:32:05 -0400
Received: from corky.net ([212.150.53.130]:33726 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S261213AbTEMNcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 09:32:02 -0400
Date: Tue, 13 May 2003 16:44:41 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: 76306.1226@compuserve.com, <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <03051307114300.19075@tabby>
Message-ID: <Pine.LNX.4.44.0305131633030.20904-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Until linux gets a real encrypted swap (the kind OpenBSD implements), you
> > can settle for encrypting your whole swap with one random key that gets
> > lost on reboot.  Encrypted loop dev with a key from /dev/random easily
> > gives you that.
>
> Ahhh not a good idea if you want job restart or suspend/resume. And large
> systems DO want a job restart... as do laptops. During suspension you can
> do anything to the disk (as in remove it, insert in another system, read
> it, then put it back ...)
>

While I agree with most of what you said in your post, I fail to see the
problem with this one.  My laptop has encrypted swap and it poses no
problem when suspending.  The disk can be taken out and read, but its
encrypted with a random key that exists only in memory so its harder to
extract.  (and if someone can extract my memory, the swap is the least of
my concerns).

Maybe you're talking about hibernation rather than suspension.  (when
everything is written to disk and the memory is wiped).  In this case,
again, the encrypted swap's key is the least of your concern since all
your memory is written to disk plaintext anyway.  If hibernation is
implemented in software, you can have it encrypted too, and require a
user-supplied key upon restarting.  If its implemented by the hardware, I
guess there isn't much you can do.  Just have the kernel do the
hibernation into an encrypted loopdev and halt the machine.


