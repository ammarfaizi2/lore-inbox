Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267142AbUBRX7G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267150AbUBRX7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:59:06 -0500
Received: from mail.shareable.org ([81.29.64.88]:55685 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S267142AbUBRX7A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:59:00 -0500
Date: Wed, 18 Feb 2004 23:58:45 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior
Message-ID: <20040218235845.GA914@mail.shareable.org>
References: <1076886183.18571.14.camel@m222.net81-64-248.noos.fr> <20040216062152.GB5192@pegasys.ws> <20040216155534.GA17323@mail.shareable.org> <20040217064755.GC9466@pegasys.ws> <20040217213714.GI24311@mail.shareable.org> <Pine.LNX.4.58.0402171400540.2154@home.osdl.org> <20040218095915.GC28599@mail.shareable.org> <Pine.LNX.4.58.0402180749120.2686@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0402180749120.2686@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Btw, from the screen man-page it appears that screen is not able to do 
> that either. You can put screen into utf-8 mode, but it sounds like it 
> just means that it passes UTF-8 through, not that it does any translation 
> from "latin1 vt100 to utf-8".

Screen works nicely.  Do this:

    echo 'defutf8 on' >> ~/.screenrc

Then screen presents a UTF-8 interface to the shell and other
programs, regardless of what kind of terminal you connect from :)

(It's a bit overkill, no actually it's a lot overkill, and you have the
annoyance of screen intercepting at least one commonly used editing key.)

(Just remember to set the LANG environment variable to include
".UTF-8" so that screen-oriented programs know to display properly.  I
do it automatically using a script which queries the current terminal,
to workaround ssh not forwarding LANG).

> I think there are a few editors that actually do ("mined" looks like it 
> should do it).

Emacs does, of course.

-- Jamie
