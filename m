Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbTESKgq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 06:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262371AbTESKgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 06:36:46 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:59632 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S262340AbTESKgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 06:36:45 -0400
Subject: Re: Recent changes to sysctl.h breaks glibc
From: Martin Schlemmer <azarah@gentoo.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030519063813.A30004@infradead.org>
References: <1053289316.10127.41.camel@nosferatu.lan>
	 <20030518204956.GB8978@holomorphy.com>
	 <1053292339.10127.45.camel@nosferatu.lan>
	 <20030519063813.A30004@infradead.org>
Content-Type: text/plain
Organization: 
Message-Id: <1053341023.9152.64.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 19 May 2003 12:43:44 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-19 at 07:38, Christoph Hellwig wrote:
> On Sun, May 18, 2003 at 11:12:19PM +0200, Martin Schlemmer wrote:
> > Yes, the standard answer.  So what kernel headers should glibc
> > be compiled against then ?
> 
> None.  But as glibc still hasn't been fixed use kernel headers from linux 2.4.
> 

Right, so who are going to tell the glibc guys that ?

-----------------------------------------------------------------
configure: error: GNU libc requires kernel header files from
Linux 2.0.10 or later to be installed before configuring.
The kernel header files are found usually in /usr/include/asm and
/usr/include/linux; make sure these directories use files from
Linux 2.0.10 or later.  This check uses <linux/version.h>, so
make sure that file was built correctly when installing the kernel
header
files.  To use kernel headers not from /usr/include/linux, use the
configure option --with-headers.
-----------------------------------------------------------------

I do not mind if thing break due to compatibility if needed to
enhance an API, etc ... gcc does that enough.

The big problem however is that every time somebody screws up
user space due to changes in kernel headers, the reply is always
the same:  "do not use kernel headers in user land"

Ok, lets say we stop doing that.  How do anything user side find
out specifics at compile time related to the kernel it should run
on ?  If we may not include kernel headers, what then?

Please understand, this is not me trolling, but everybody always
have the same answer for issues like this, but no solutions.


Thanks,

-- 
Martin Schlemmer


