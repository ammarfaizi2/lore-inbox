Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266470AbUBLPK5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 10:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266474AbUBLPK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 10:10:57 -0500
Received: from h0060089601a0.ne.client2.attbi.com ([24.34.92.88]:2771 "EHLO
	sevoog.kriation.com") by vger.kernel.org with ESMTP id S266470AbUBLPKz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 10:10:55 -0500
Date: Thu, 12 Feb 2004 10:10:48 -0500
From: Armen Kaleshian <akaleshian@kriation.com>
To: Ralica <larry@podovinastilki.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IMAP Error
Message-ID: <20040212151048.GB10394@sevoog.kriation.com>
References: <002101c3f160$f4a0a8f0$0500a8c0@sea> <20040212140623.GA10394@sevoog.kriation.com> <001301c3f178$ab8e5ff0$0500a8c0@sea>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001301c3f178$ab8e5ff0$0500a8c0@sea>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry. I completely missed it in your previous e-mail.

Configure is basically complaining that libgdbm can not be found; it has nothing
to do with IMAP. If you were trying to build something else that was looking for
the same library, it would probably have the same problem...

You could do one of two things:

1) Check /etc/ld.so.conf for /usr/lib; if it doesn't exist, add it, remove your
current /etc/ld.so.cache and run /sbin/ldconfig [OS dependent] to rebuild the
library cache on your system. Run configure again, and that should fix it.

2) This solution is highly discouraged but might make it work... add whatever
paths exist in /etc/ld.so.conf to an exported LD_LIBRARY_PATH environment
variable, as well as /usr/lib delimited by a ':'. Run configure after you've
exported the variable.

Good Luck!

--Armen

On Thu, Feb 12, 2004 at 04:58:27PM +0200, Ralica wrote:
: Hi, Armen
: As I writed before:
: 
: > : I have /usr/include/gdbm.h and /usr/lib/libgdbm.a         libgdbm.la
: > : libgdbm.so        libgdbm.so.2      libgdbm.so.2.0.0
: > : 
: 
: 
