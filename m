Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266577AbUBQWXN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 17:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266654AbUBQWV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 17:21:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:40069 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266657AbUBQWM3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 17:12:29 -0500
Date: Tue, 17 Feb 2004 14:12:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
cc: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior
In-Reply-To: <20040217213714.GI24311@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0402171400540.2154@home.osdl.org>
References: <1076886183.18571.14.camel@m222.net81-64-248.noos.fr>
 <20040216062152.GB5192@pegasys.ws> <20040216155534.GA17323@mail.shareable.org>
 <20040217064755.GC9466@pegasys.ws> <20040217213714.GI24311@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004, Jamie Lokier wrote:
> 
> Many terminals will not ever display UTF-8.  Think: all the serial terminals.
> 
> This is why I think "stty utf8" or something along those lines would
> be useful.  The terminal itself doesn't have to talk UTF-8; however,
> the applications talking with /dev/tty would always see UTF-8.
> 
> That seems to solve most of the practical user interface problems of
> the command line, in one single clean place.

Doesn't "screen" already do this? I don't think you want to have the
locale handling in the kernel, along with translation of multi-key
characters (and from things like CJK terminals? I don't know what format
they send).  Sounds like you should use a user-mode thing that knows about
locales...

		Linus
