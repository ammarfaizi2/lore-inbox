Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261636AbULNTob@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261636AbULNTob (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 14:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbULNTob
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 14:44:31 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:12323 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261636AbULNToY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 14:44:24 -0500
Date: Tue, 14 Dec 2004 20:45:31 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Werner Almesberger <wa@almesberger.net>,
       Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, David Woodhouse <dwmw2@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041214194531.GB13811@mars.ravnborg.org>
Mail-Followup-To: Horst von Brand <vonbrand@inf.utfsm.cl>,
	Werner Almesberger <wa@almesberger.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Paul Mackerras <paulus@samba.org>, Greg KH <greg@kroah.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
	hch@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
	libc-hacker@sources.redhat.com
References: <20041214135029.A1271@almesberger.net> <200412141923.iBEJNCY9011317@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412141923.iBEJNCY9011317@laptop11.inf.utfsm.cl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 04:23:12PM -0300, Horst von Brand wrote:
> 
> > Therefore, stdint.h types would mainly be used with new interfaces,
> > or in intermediate definitions which are not themselves part of the
> > interface. Of course, the latter would have to consider pollution
> > issues.
> 
> They _can't_ show up in interfaces unless you specify that stdint.h has to
> be included before them... and I'd awise against any needless interface
> fattening. Besides, using them in the kernel would then mean pulling in
> stdint.h there... and you get the same mess, the other way around ("What
> userspace headers are OK to pull in when compiling the kernel?"). Better
> don't.

Today we only pull in stdarg.h from userspace - actually a compiler
dependent file. We shall not introduce anything to pull more stuff in
from userspace. We have namespace issues enough - keeping the kernel out
of userspace namespace is important.

	Sam
