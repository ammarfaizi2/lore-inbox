Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265108AbSLQSjw>; Tue, 17 Dec 2002 13:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265276AbSLQSjw>; Tue, 17 Dec 2002 13:39:52 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:23779
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265108AbSLQSjv>; Tue, 17 Dec 2002 13:39:51 -0500
Subject: Re: Intel P6 vs P7 system call performance
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hpa@transmeta.com
In-Reply-To: <3DFF6D4B.3060107@redhat.com>
References: <Pine.LNX.4.44.0212170948380.2702-100000@home.transmeta.com> 
	<3DFF6D4B.3060107@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Dec 2002 19:26:26 +0000
Message-Id: <1040153186.20780.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-17 at 18:30, Ulrich Drepper wrote:
> demultiplexing happens in the kernel.  Do we want to do this at
> userlevel?  This would allow almost no-cost determination of those
> syscalls which can be handled at userlevel (getpid, getppid, ...).

getppid changes and so I think has to go to kernel (unless we go around
patching user pages on process exit [ick]). getpid can already be done
by reading it once at startup time and caching the data.


