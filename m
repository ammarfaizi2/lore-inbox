Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261414AbTEUHvw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 03:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTEUHmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 03:42:55 -0400
Received: from zeus.kernel.org ([204.152.189.113]:58838 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261414AbTEUHlZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 03:41:25 -0400
Subject: Re: [patch] futex patches, futex-2.5.69-A2
From: Martin Schlemmer <azarah@gentoo.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>,
       Ulrich Drepper <drepper@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030520205512.A5889@infradead.org>
References: <20030520150826.A18282@infradead.org>
	 <Pine.LNX.4.44.0305201748020.14480-100000@localhost.localdomain>
	 <20030520205512.A5889@infradead.org>
Content-Type: text/plain
Organization: 
Message-Id: <1053493564.9142.1504.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 21 May 2003 07:06:57 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-20 at 21:55, Christoph Hellwig wrote:
> On Tue, May 20, 2003 at 06:02:07PM +0200, Ingo Molnar wrote:
> > you havent ever used Ulrich's nptl-enabled glibc, have you? It will boot
> > on any 2.4.1+ kernel, with and without nptl/tls support. It switches the
> > threading implementation depending on the kernel features it detects.
> 
> I have built a nptl-enabled glibc and no, it's doesn't work on 2.4 at all.
> 

It is because you only compiled it with nptl support.

In recent (nptl enabled) Redhat glibc's glibc is build two times.
1) without nptl
2) with nptl

The version without nptl support is then installed into the 'default'
location.  The other is installed into /lib/tls/ and /usr/lib/tls/.
ld.so is then hacked (maybe in mainline glibc now?) to load the tls
enabled versions of the libraries only if the kernel/hardware support
it.


Regards,

-- 
Martin Schlemmer


