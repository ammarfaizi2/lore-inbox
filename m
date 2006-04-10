Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751130AbWDJK7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbWDJK7e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 06:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751139AbWDJK7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 06:59:34 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34534 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751130AbWDJK7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 06:59:33 -0400
Date: Mon, 10 Apr 2006 02:58:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/19] kconfig: move .kernelrelease
Message-Id: <20060410025851.641022a0.akpm@osdl.org>
In-Reply-To: <20060410104250.GA24160@mars.ravnborg.org>
References: <Pine.LNX.4.64.0604091728560.23148@scrub.home>
	<20060410015727.69b5c1f6.akpm@osdl.org>
	<20060410104250.GA24160@mars.ravnborg.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> wrote:
>
> On Mon, Apr 10, 2006 at 01:57:27AM -0700, Andrew Morton wrote:
> > Roman Zippel <zippel@linux-m68k.org> wrote:
> > >
> > > This moves the .kernelrelease file into include/config directory.
> > >  Remove its generation from the config step, if the config step doesn't
> > >  leave a proper .config behind, it triggers a call to silentoldconfig.
> > >  Instead its generation can be done via proper dependencies.
> > 
> > Well that was a pita.  I was using that file in my kernel installation
> > script.
> > 
> > Your changelog says what the patch does, but gives no indication of why it
> > did it.
> > 
> > What do we get back for the breakage which this will cause?
> > 
> > Now I'm going to have to look for both .kernelrelease and
> > include/config/kernel.release and work out which one has the more recent
> > mtime.  grr.
> That you have for not using 'make kernelrelease' - he ;-)
> Did you not know, or did make kernelrelease not do what you expected?
> 

I stopped using `make kernelrelease' when it did something bad when used
from another machine across NFS.

<tries it>

hm, it takes nearly five seconds, but it wasn't that - something actually
broke.  But I forget what it was.  I'll put it back and will wait for it
to reoccur.

