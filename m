Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUFFH6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUFFH6L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 03:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbUFFH6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 03:58:11 -0400
Received: from codepoet.org ([166.70.99.138]:6299 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S263024AbUFFH6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 03:58:08 -0400
Date: Sun, 6 Jun 2004 01:57:54 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kalin KOZHUHAROV <kalin@ThinRope.net>,
       Davide Libenzi <davidel@xmailserver.org>, Robert Love <rml@ximian.com>,
       Chris Wedgwood <cw@f00f.org>, Arjan van de Ven <arjanv@redhat.com>,
       Russell Leighton <russ@elegant-software.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: clone() <-> getpid() bug in 2.6?
Message-ID: <20040606075754.GA10642@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Linus Torvalds <torvalds@osdl.org>,
	Kalin KOZHUHAROV <kalin@ThinRope.net>,
	Davide Libenzi <davidel@xmailserver.org>,
	Robert Love <rml@ximian.com>, Chris Wedgwood <cw@f00f.org>,
	Arjan van de Ven <arjanv@redhat.com>,
	Russell Leighton <russ@elegant-software.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <40C1E6A9.3010307@elegant-software.com> <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org> <20040605205547.GD20716@devserv.devel.redhat.com> <20040605215346.GB29525@taniwha.stupidest.org> <1086475663.7940.50.camel@localhost> <Pine.LNX.4.58.0406051553130.2261@bigblue.dev.mdolabs.com> <Pine.LNX.4.58.0406051610430.7010@ppc970.osdl.org> <40C2A6E4.7020103@ThinRope.net> <Pine.LNX.4.58.0406052244290.7010@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406052244290.7010@ppc970.osdl.org>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Jun 05, 2004 at 11:07:25PM -0700, Linus Torvalds wrote:
> qmail is a piece of crap. The source code is completely unreadable, and it 
> seems to think that "getpid()" is a good source of random data. Don't ask 
> me why.
> 
> It literally does things like
> 
> 	random = now() + (getpid() << 16);
[-----------snip-----------]

http://sources.redhat.com/cgi-bin/cvsweb.cgi/~checkout~/libc/sysdeps/posix/tempname.c?rev=1.36&content-type=text/plain&cvsroot=glibc

    /* Get some more or less random data.  */
    random_time_bits = ((uint64_t) tv.tv_usec << 16) ^ tv.tv_sec;
    value += random_time_bits ^ __getpid ();

etc....

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
