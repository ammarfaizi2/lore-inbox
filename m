Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262668AbTI1Sss (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 14:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262656AbTI1Ssr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 14:48:47 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:16652 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262668AbTI1Sqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 14:46:46 -0400
Date: Sun, 28 Sep 2003 20:46:42 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Bernardo Innocenti <bernie@develer.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test6
Message-ID: <20030928184642.GA1681@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Bernardo Innocenti <bernie@develer.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0309281213240.4929-100000@callisto> <Pine.LNX.4.44.0309281035370.6307-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309281035370.6307-100000@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 28, 2003 at 10:37:36AM -0700, Linus Torvalds wrote:
> 
> This, btw, is a pretty common thing. I wonder what we could do to make 
> sure that different architectures wouldn't have so different include file 
> structures. It's happened _way_ too often.
> 
> Any ideas?

Without too much thinking....
Would it help to require all major[1] header files to include all the
header files needed for them to compile?
We could make that part of the build process or we could make that an
optional step.

Obviously that would not solve any issues in asm-$(ARCH).

[1] There are ~600 files in include/linux - we could pick up the
50 most important and checkcompile them.

	Sam
