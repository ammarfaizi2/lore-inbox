Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751634AbWIMGzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbWIMGzy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 02:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751624AbWIMGzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 02:55:54 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56020 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751121AbWIMGzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 02:55:54 -0400
Subject: Re: OT: calling kernel syscall manually
From: David Woodhouse <dwmw2@infradead.org>
To: Albert Cahalan <acahalan@gmail.com>
Cc: guest01@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <787b0d920609122235j57ac327ckcc8d08832fb3989c@mail.gmail.com>
References: <787b0d920609122235j57ac327ckcc8d08832fb3989c@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 13 Sep 2006 07:55:30 +0100
Message-Id: <1158130530.18619.156.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5.dwmw2.1) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-13 at 01:35 -0400, Albert Cahalan wrote:
> > The third one has always been broken on i386 for PIC code
> 
> No, I was just using it today in PIC i386 code.
> The %ebx register gets pushed, the needed value
> gets moved into %ebx, the int 0x80 is done, and
> the %ebx register gets popped. Only a few odd
> calls like clone() need something different.

That's a very recent change -- it was broken for years before that.

> > and was pointless anyway, since glibc provides this
> > functionality. The kernel method has been removed from
> > userspace visibility all architectures, and we plan to
> > remove it entirely in 2.6.19 since it's not at all useful.
> 
> It's damn useful. Hint: Linux does not require glibc.

Are you being deliberately obtuse or is it just a natural talent?

Other C libraries also provide syscall() -- at least dietlibc and uClibc
do.

Kernel headers do not exist to provide a library of random crap for
userspace to use.
 
-- 
dwmw2

