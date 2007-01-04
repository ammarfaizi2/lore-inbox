Return-Path: <linux-kernel-owner+w=401wt.eu-S964843AbXADNIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964843AbXADNIp (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 08:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964849AbXADNIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 08:08:45 -0500
Received: from aa017msg.fastweb.it ([213.140.2.84]:49598 "EHLO
	aa017msg.fastweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964848AbXADNIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 08:08:44 -0500
Date: Thu, 4 Jan 2007 14:08:23 +0100
From: Andrea Gelmini <gelma@gelma.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       a.bonometti@gmail.com
Subject: Re: VM: Fix nasty and subtle race in shared mmap'ed page writeback
Message-ID: <20070104130823.GB28470@gelma.net>
References: <200612291859.kBTIx2kq031961@hera.kernel.org> <20061229224309.GA23445@gelma.net> <459734CE.1090001@yahoo.com.au> <20061231135031.GC23445@gelma.net> <459C7B24.8080008@yahoo.com.au> <Pine.LNX.4.64.0701032031400.3661@woody.osdl.org> <20070103214121.997be3e6.akpm@osdl.org> <459C98BF.5080409@yahoo.com.au> <20070103221220.c4589831.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070103221220.c4589831.akpm@osdl.org>
Weight: 77.8 kg (171.51964 lbs)
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 10:12:20PM -0800, Andrew Morton wrote:
> > Anyway that leaves us with the question of why Andrea's database is getting
> > corrupted. Hopefully he can give us a minimal test-case.
> 
> It'd odd that stories of pre-2.6.19 BerkeleyDB corruption are now coming
> out of the woodwork.  It's the first I've ever heard of them.

of course, because nobody had never thought it could be a kernel bug.
since first release of klibido we had db corruption. so Bauno, main
author/programmer, introduced various check in it. so we had found db
corruption. he had talked with sleepycat (it happens long before Oracle
buys them), they were very kind, but in the meanwhile lot of code was
changed, so he had decided to wait for other tests.
anyway, in the klibido mailing list people started to complain about
corruption db. we spended a lot of time trying to find clues. anyway, to
make this part very short, after months we got clear that with Red
Hat/Suse kernel we got no crash, and with
vanilla/Debian/Ubuntu/Slackware we can reproduce it with simple action.
so, we started checking klibido code, g++ versions, qt/kde versions, and
so on. but nothing changed.
well, all this story could mean nothing, but then I said "let's look at
other projects using bdb", and I subscribed to different mailing lists.
you can change klibido with postgrey/bogofilter, and you've same story.
if you have time to look at their mailing list archive, you'll see
people complain about db corruption, people telling them "it happens",
and, usually, switching to sqlite.
nobody wrote/write to kernel mailing list because nobody thought/think
it could be a kernel bug.

anyway, the important thing is that I can give you an image of my debian
machine where you can have a lot/not at all corruption just switching
bitween debian kernel (linux-image-2.6.18-3-686) and vanilla
2.6.20-rc2-git1.

by the way, klibido works also under BSD, and we have no bug report
about db corruption (I know, we dunno how many user, which DB size, and
so on).

I repeat, all these things are not so important because klibido, but
because in common with other projects.

I put Bauno, klibido author, in Cc (it also speak english better thank
me...)

thanks a lot for your time,
gelma 
