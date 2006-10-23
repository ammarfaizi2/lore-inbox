Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751726AbWJWVET@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbWJWVET (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 17:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbWJWVET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 17:04:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5850 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751726AbWJWVES convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 17:04:18 -0400
Date: Mon, 23 Oct 2006 14:04:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Magnus =?ISO-8859-1?B?TeTkdHTk?= <novell@kiruna.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm2
Message-Id: <20061023140403.03fee371.akpm@osdl.org>
In-Reply-To: <200610232254.15638.novell@kiruna.se>
References: <20061020015641.b4ed72e5.akpm@osdl.org>
	<200610232254.15638.novell@kiruna.se>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.19; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 23 Oct 2006 22:54:15 +0200 Magnus M‰‰tt‰ <novell@kiruna.se> wrote:
> On Friday 20 October 2006 10:56, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc2/2.6.19-rc2-mm2/
> > 
> > - Added the IOAT tree as git-ioat.patch (Chris Leech)
> > 
> > - I worked out the git magic to make the wireless tree work
> >   (git-wireless.patch).  Hopefully it will be in -mm more often now.
> > 
> 
> I get this BUG and oops everytime I try to start kmail, so I had to fall back to 2.6.18-mm2
> to send this mail:
> 
> [  316.283343] BUG: sleeping function called from invalid context at mm/slab.c:3014
> [  316.305500] in_atomic():0, irqs_disabled():1

Someone disabled local interrupts then forgot to turn them on again.  I
wonder what kmail is doing to trigger this?

Please send your .config and I'll see if I can reproduce it.

If not, and if the next -mm is still doing this, it'd be good if
you could run a bisection search, find the buggy patch.

Thanks.
