Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266114AbTGTKYH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 06:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266774AbTGTKYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 06:24:07 -0400
Received: from [213.39.233.138] ([213.39.233.138]:9925 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S266114AbTGTKYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 06:24:05 -0400
Date: Sun, 20 Jul 2003 12:38:56 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: postmaster@lougher.demon.co.uk
Cc: linux-kernel@vger.kernel.org, junkio@cox.net
Subject: Re: [PATCH] Port SquashFS to 2.6
Message-ID: <20030720103856.GC25468@wohnheim.fh-wedel.de>
References: <20030720082217.GA25468@wohnheim.fh-wedel.de> <E19eBEo-0007h6-0Z@anchor-post-35.mail.demon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E19eBEo-0007h6-0Z@anchor-post-35.mail.demon.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 July 2003 11:16:18 +0100, postmaster@lougher.demon.co.uk wrote:
> joern@wohnheim.fh-wedel.de wrote:
> > 
> > As a rule of thumb, stay below 1k or you will get regular email from
> > me. :)
> 
> I tend to allocate (small) buffers on the stack, when their size does not
> seem to warrant either: a globally kmalloced buffer and consequent locking,
> or a locally kmalloced buffer kfreed on exit from the function, which seems
> wasteful. However, if 1K is the perceived wisdom on stack limits, then I will
> alter the code.

At least you should think twice before going above.  Even with wli's
stack reduction work applied, you still have close to 4k for kernel
stack.  But measuring the stack consumption of all the possible call
chains in the kernel is still a hard problem, so you will have a hard
time proving that any one bigger stack allocation is fine.

Jörn

-- 
When people work hard for you for a pat on the back, you've got
to give them that pat.
-- Robert Heinlein
