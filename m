Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262977AbSJOOGB>; Tue, 15 Oct 2002 10:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263135AbSJOOGA>; Tue, 15 Oct 2002 10:06:00 -0400
Received: from kim.it.uu.se ([130.238.12.178]:39100 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S262977AbSJOOF6>;
	Tue, 15 Oct 2002 10:05:58 -0400
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15788.8728.734070.225906@kim.it.uu.se>
Date: Tue, 15 Oct 2002 16:11:36 +0200
To: Rik van Riel <riel@conectiva.com.br>
Cc: Chris Wedgwood <cw@f00f.org>, Daniele Lugli <genlogic@inrete.it>,
       <linux-kernel@vger.kernel.org>
Subject: Re: unhappy with current.h
In-Reply-To: <Pine.LNX.4.44L.0210142159580.22993-100000@imladris.surriel.com>
References: <20021014202404.GA10777@tapu.f00f.org>
	<Pine.LNX.4.44L.0210142159580.22993-100000@imladris.surriel.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel writes:
 > On Mon, 14 Oct 2002, Chris Wedgwood wrote:
 > > On Mon, Oct 14, 2002 at 09:46:08PM +0200, Daniele Lugli wrote:
 > >
 > > > I recently wrote a kernel module which gave me some mysterious
 > > > problems. After too many days spent in blood, sweat and tears, I found the cause:
 > >
 > > > *** one of my data structures has a field named 'current'. ***
 > >
 > > gcc -Wshadow
 > 
 > Would it be a good idea to add -Wshadow to the kernel
 > compile options by default ?

While I'm not defending macro abuse, please note that Daniele's problem
appears to have been caused by using g++ instead of gcc or gcc -x c to
compile a kernel module. Daniele's later example throws a syntax error
in gcc, since the cpp output isn't legal C ...

Hence I fail to see the utility of hacking in kludges for something
that's not supposed to work anyway.
