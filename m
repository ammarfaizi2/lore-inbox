Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280047AbRKDXUJ>; Sun, 4 Nov 2001 18:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280038AbRKDXT7>; Sun, 4 Nov 2001 18:19:59 -0500
Received: from [63.83.207.133] ([63.83.207.133]:40466 "EHLO
	mailout1.lsv.evoke.com") by vger.kernel.org with ESMTP
	id <S280032AbRKDXTn>; Sun, 4 Nov 2001 18:19:43 -0500
Message-ID: <8E3BD6C91C42EC44AF5BEE87C73F9CBC0DB135@mail8-bld.lsv.raindance.com>
From: Craig Thrall <cthrall@raindance.com>
To: "'jakob@unthought.net'" <jakob@unthought.net>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Date: Sun, 4 Nov 2001 16:06:25 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Problem:  Could it be made simpler to parse from scripting languages,
> without making it less elegant to parse in plain C ?

Yes.  At one point, somebody suggested XML.  Now, as much as I hate the fact
that people somehow equate high-tech with tags, I think whomever originally
suggested it might be on to something.  :)

Fact is, just about EVERY language out there has some sort of utility to
parse XML.  There's expat for C, Perl and Python have libs, etc.  We could
even write a proc DTD that could specify the valid data types.

There are two problems:

1. Performance - it's slower to go through a library that outputs XML than
do a printf("%d", pid) or the like.

2. Space - based on a little experience using XML as a transport, the space
used by the tags adds up.

3. Work - writing a good package to do this, and rewriting bits of the
kernel to use it.  I'll volunteer my time.

Just a thought,

Craig
