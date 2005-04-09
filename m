Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVDIRIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVDIRIm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 13:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVDIRIl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 13:08:41 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:60350 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261272AbVDIRIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 13:08:39 -0400
Date: Sat, 9 Apr 2005 10:08:27 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: ross@jose.lug.udel.edu, cw@f00f.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
Message-Id: <20050409100827.7380a53e.pj@engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0504090916550.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	<20050408041341.GA8720@taniwha.stupidest.org>
	<Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
	<20050408071720.GA23128@jose.lug.udel.edu>
	<Pine.LNX.4.58.0504080758420.28951@ppc970.osdl.org>
	<20050409085017.7edf2c9a.pj@engr.sgi.com>
	<Pine.LNX.4.58.0504090916550.1267@ppc970.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:
> (you need to remember to escape '%' 
> too when you do that ;).

No - don't have to.  Not if I don't mind giving fools that embed
newlines in paths second class service.

In my case, if I create a file named "foo\nbar", then backup and restore
it, I end up with a restored file named "foo%0Abar".  If I had backed up
another file named "foo%0Abar", and now restore it, it collides, and
last one to be restored wins.  If I really need the "foo\nbar" file back
as originally named, I will have to dig it out by hand.

I dare say that Linux kernel source does not require first class support
for newlines embedded in pathnames.

> ASCII isn't magical.

No - but it's damn convenient.  Alot of tools work on line-oriented
ASCII that don't work elsewhere.

I guess Perl-hackers won't care much, but those working with either
classic shell script tools or Python will find line formatted ASCII more
convenient.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
