Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751245AbWALNcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbWALNcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 08:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWALNcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 08:32:10 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:16716 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S1751245AbWALNcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 08:32:09 -0500
Date: Thu, 12 Jan 2006 08:31:54 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH 15/15] kconf: Check for eof from input stream.
In-reply-to: <Pine.LNX.4.61.0601121342200.11765@scrub.home>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <1137072715.4254.24.camel@grayson>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.4
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <0ISL003ZI97GCY@a34-mta01.direcway.com>
 <200601090109.06051.zippel@linux-m68k.org> <1136779153.1043.26.camel@grayson>
 <200601091232.56348.zippel@linux-m68k.org> <1136814126.1043.36.camel@grayson>
 <Pine.LNX.4.61.0601120019430.30994@scrub.home>
 <1137031253.9643.38.camel@grayson>
 <Pine.LNX.4.61.0601121155450.30994@scrub.home>
 <1137068880.4254.8.camel@grayson>
 <Pine.LNX.4.61.0601121342200.11765@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 13:48 +0100, Roman Zippel wrote:
> Hi,
> 
> On Thu, 12 Jan 2006, Ben Collins wrote:
> 
> > > silentoldconfig gives you exactly the same information. Both conf and 
> > > oldconfig will change invisible options without telling you, so it's not 
> > > exact at all.
> > > If you can't trust a silent oldconfig, a more verbose oldconfig can't tell 
> > > you anything else, if it would it's a bug.
> > 
> > silentoldconfig tells you a lot less, agreed?
> 
> No.

So you are saying that silentoldconfig outputs no less information than
oldconfig? No output compared to a full config output (yes, with some
special cased invisible options, but the same output that a user would
see if manually configuring).

My point is that you are making oldconfig and silentoldconfig operate
differently when they encounter a closed stdin. You are making them
inconsistent. And so far, you have yet to give a valid reason to do so.
I've been giving very valid reasons why they should work the same, and
why the behavior is correct for them to work that way.

What is the reason for silentoldconfig to fail in this way, and for
oldconfig not to? I suspect you have some special usage of your own for
which you depend on this functionality.

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

