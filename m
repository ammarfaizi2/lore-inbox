Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264791AbUDWM5H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264791AbUDWM5H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 08:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264793AbUDWM5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 08:57:06 -0400
Received: from gprs214-21.eurotel.cz ([160.218.214.21]:6017 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264791AbUDWM47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 08:56:59 -0400
Date: Fri, 23 Apr 2004 14:56:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SOFTWARE_SUSPEND as a module
Message-ID: <20040423125650.GA30503@elf.ucw.cz>
References: <20040422120417.GA2835@gondor.apana.org.au> <20040423005617.GA414@elf.ucw.cz> <20040423093836.GA10550@gondor.apana.org.au> <20040423122123.GG976@elf.ucw.cz> <20040423122738.GA12504@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040423122738.GA12504@gondor.apana.org.au>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > If you really ensure userspace is stopped, you should be fine.
> > 
> > *But* kernel is only correct if userspace is "correct", and need for
> > all processes stopped is not going to be obvious to users. I'd like
> > kernel to be kernel to be okay regardless what stupid stuff happens in
> > userspace. (Well, they really should not scribble on disks).
> 
> But in this context if user space is not doing the right thing,
> you'll lose whatever the kernel does.  For example, if user space
> writes to any file systems mounted in the suspended image, then
> you'll get corruption no matter what the kernel does.

Hmm, this should keep users from doing so. Alternative solution is to
add your own warning ;-).

								Pavel

 * BIG FAT WARNING *********************************************************
 *
 * If you touch anything on disk between suspend and resume...
 *                              ...kiss your data goodbye.
 *



-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
