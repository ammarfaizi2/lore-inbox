Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVDIRgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVDIRgG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 13:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbVDIRgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 13:36:06 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:40657 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261358AbVDIRgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 13:36:02 -0400
Date: Sat, 9 Apr 2005 10:35:25 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: jgarzik@pobox.com, matthias.christian@tiscali.de, andrea@suse.de,
       cw@f00f.org, linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
Message-Id: <20050409103525.6f65d550.pj@engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0504090902170.1267@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	<20050408041341.GA8720@taniwha.stupidest.org>
	<Pine.LNX.4.58.0504072127250.28951@ppc970.osdl.org>
	<20050408071428.GB3957@opteron.random>
	<Pine.LNX.4.58.0504080724550.28951@ppc970.osdl.org>
	<4256AE0D.201@tiscali.de>
	<Pine.LNX.4.58.0504081010540.28951@ppc970.osdl.org>
	<4256C0F8.6030008@pobox.com>
	<Pine.LNX.4.58.0504081114220.28951@ppc970.osdl.org>
	<20050409084003.02c83b9f.pj@engr.sgi.com>
	<Pine.LNX.4.58.0504090902170.1267@ppc970.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  (b) while I depend on the fact that if the SHA of an object matches, the 
>      objects are the same, I generally try to avoid the reverse 
>      dependency.

It might be a valid point that you want to leave the door open to using
a different (than SHA1) digest.  (So this means you going to store it
as an ASCII string, right?)

But I don't see how that applies here.  Any optimization that avoids
rereading old versions if the digests match will never trigger on the
day you change digests.  No problem here - you doomed to reread the old
version in any case.

Either you got your logic backwards, or I need another cup of coffee.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
