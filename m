Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbULNSBo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbULNSBo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 13:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbULNSAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 13:00:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:39314 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261591AbULNR7u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 12:59:50 -0500
Date: Tue, 14 Dec 2004 09:59:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andreas Schwab <schwab@suse.de>
cc: Werner Almesberger <wa@almesberger.net>, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>, David Woodhouse <dwmw2@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, David Howells <dhowells@redhat.com>,
       hch@infradead.org, aoliva@redhat.com, linux-kernel@vger.kernel.org,
       libc-hacker@sources.redhat.com
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
In-Reply-To: <jek6rkhlax.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.58.0412140958320.3279@ppc970.osdl.org>
References: <19865.1101395592@redhat.com> <20041125165433.GA2849@parcelfarce.linux.theplanet.co.uk>
 <1101406661.8191.9390.camel@hades.cambridge.redhat.com> <20041127032403.GB10536@kroah.com>
 <16810.24893.747522.656073@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0411281710490.22796@ppc970.osdl.org> <20041214025110.A28617@almesberger.net>
 <Pine.LNX.4.58.0412140734340.3279@ppc970.osdl.org> <jek6rkhlax.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Dec 2004, Andreas Schwab wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > This is a common issue with namespace pollution. For example, this program 
> > is perfectly valid afaik (well, except for being _stupid_, but that's 
> > another issue):
> >
> > 	#include <stdio.h>
> >
> > 	const char *int32_t(int i)
> > 	{
> > 		return i ? "non-zero" : "zero";
> > 	}
> 
> Actually this is not allowed in POSIX.  _Any_ header may define any
> identifier ending with "_t".

.. and that's POSIX.

It's not true for BSD_SOURCE, for example.

WHICH IS MY POINT, DAMMIT!

How hard is it to understand? There are millions of different standards, 
many of them without any standards body at all, and just plain standards 
by virtue of "that's how people have done it for years".

uint32_t is totally useless for the kernel. We should never ever use it.

		Linus
