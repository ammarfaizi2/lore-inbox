Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWJLMiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWJLMiD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 08:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWJLMiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 08:38:03 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:58802 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1750785AbWJLMiB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 08:38:01 -0400
Date: Thu, 12 Oct 2006 14:33:53 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nikita Danilov <nikita@clusterfs.com>
cc: Andreas Schwab <schwab@suse.de>, "H. Peter Anvin" <hpa@zytor.com>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] use %p for pointers
In-Reply-To: <17710.12002.651934.995885@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.61.0610121432260.19282@yvahk01.tjqt.qr>
References: <E1GXPU5-0007Ss-HU@ZenIV.linux.org.uk>
 <Pine.LNX.4.61.0610111316120.26779@yvahk01.tjqt.qr> <20061011145441.GB29920@ftp.linux.org.uk>
 <452D3BB6.8040200@zytor.com> <17710.8478.278820.595718@gargle.gargle.HOWL>
 <jehcy9rbyr.fsf@sykes.suse.de> <17710.12002.651934.995885@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > man 3 printf:
> > >
> > >        p      The void * pointer argument is printed in hexadeci-
> > >               mal (as if by %#x or %#lx).
> > >
> > > so %p already has to output '0x',
> > 
> > That is an detail of this particular implementation.
> > 
> > > it's lib/vsprintf.c to blame for non-conforming behavior.
> > 
> > The standard makes it completely implementation defined.
>
>Yes, but POSIX/SUS aside, at least we might make kernel version closer
>to Linux user-level.

I do agree.

#include <stdio.h>
int main(void) {
    return printf("%p %p\n", main, NULL);
}

In glibc will print "0x7555562c (nil)" which seems ok enough.


	-`J'
-- 
