Return-Path: <linux-kernel-owner+w=401wt.eu-S964849AbXAJNze@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbXAJNze (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 08:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964859AbXAJNze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 08:55:34 -0500
Received: from aa015msg.fastweb.it ([213.140.2.82]:36310 "EHLO
	aa015msg.fastweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964849AbXAJNze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 08:55:34 -0500
Date: Wed, 10 Jan 2007 14:54:53 +0100
From: Andrea Gelmini <gelma@gelma.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM: Fix nasty and subtle race in shared mmap'ed page writeback
Message-ID: <20070110135453.GH7947@gelma.net>
References: <200612291859.kBTIx2kq031961@hera.kernel.org> <20061229224309.GA23445@gelma.net> <459734CE.1090001@yahoo.com.au> <20061231135031.GC23445@gelma.net> <459C7B24.8080008@yahoo.com.au> <Pine.LNX.4.64.0701032031400.3661@woody.osdl.org> <20070103214121.997be3e6.akpm@osdl.org> <459C98BF.5080409@yahoo.com.au> <20070104131612.GC28470@gelma.net> <459DE3C6.20302@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459DE3C6.20302@yahoo.com.au>
Weight: 77.8 kg (171.51964 lbs)
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2007 at 04:36:06PM +1100, Nick Piggin wrote:
> I was thinking like a 100 line C program that I can reproduce here ;)
not soon, but I'll try to produce it.

> If you can even describe the steps it does: (eg. mmap file A, write(2) to
> it, truncate it, ...., should contain 1s but it contains 0s!), then we
> might have some suggestions to try.
I ignore this... I mean, BerkelyDB does all this on its own (we just
talk with the library). we never touch directly the DB.

> One obvious thing is change filesystems or filesystem block sizes, try
> ext2 or even tmpfs. Another is to try using write(2) instead of mmap to
> write data.
well, I tried all filesystems, tmpfs also. I know BDB use a lot mmap.

thanks,
gelma

