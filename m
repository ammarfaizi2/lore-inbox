Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbWI1Era@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWI1Era (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 00:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751487AbWI1Era
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 00:47:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32445 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751313AbWI1Er3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 00:47:29 -0400
Date: Wed, 27 Sep 2006 21:47:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-scsi@vger.kernel.org, Greg KH <greg@kroah.com>,
       LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Illustration of warning explosion silliness
Message-Id: <20060927214719.cbeebaf4.akpm@osdl.org>
In-Reply-To: <451B52B0.1090801@garzik.org>
References: <20060928005830.GA25694@havoc.gtf.org>
	<20060927183507.5ef244f3.akpm@osdl.org>
	<451B29FA.7020502@garzik.org>
	<20060927203417.f07674de.akpm@osdl.org>
	<451B4D58.9070401@garzik.org>
	<20060927213628.ef12b1ed.akpm@osdl.org>
	<451B52B0.1090801@garzik.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 00:42:24 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> This thing introduces endless build noise we won't 
> kill for years, making it much harder to spot much more serious stuff.

That's true, and it hurt.  But there are a lot of real bugs in there.

I thought of adding a stricter __must_check like

#ifdef CONFIG_MUST_CHECK_ANAL
#define __must_check_anal __must_check
#else
#define __must_check_anal
#endif

which we can still do, of course.

But it'd be better to fix the bugs...
