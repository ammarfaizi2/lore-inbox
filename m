Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315275AbSEURvr>; Tue, 21 May 2002 13:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315277AbSEURvq>; Tue, 21 May 2002 13:51:46 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:19463 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S315275AbSEURvo>; Tue, 21 May 2002 13:51:44 -0400
Date: Tue, 21 May 2002 13:48:09 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: suid bit on directories
In-Reply-To: <Pine.LNX.4.44.0205201102500.2227-100000@twinlark.arctic.org>
Message-ID: <Pine.LNX.3.96.1020521134143.1427A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2002, dean gaudet wrote:

> On Mon, 20 May 2002, Michael Hoennig wrote:
> 
> > Why do you ignore my example? In my example the use who runs the webserver
> > owns all the files, that is wrong. With the suid bit on directories, this
> > could be fixed.
> 
> CAP_FCHOWN would appear to accomplish what you need (with the bonus of
> already existing in modern linux kernels)... the webserver should be able
> to chown away a file if it's given this capability.

This is a useful point, but doesn't address the intent of the original
proposal. The solution you propose gives VERY powerful capabilities to a
process, and if I undestand how it works gives them in every directory.

By putting them on a single directory like setgid, you allow any tool to
operate on files in the directory, given that the process has directory
access to do so. Think "groupware" and people working on a project.

Both are useful, of course, but they are NOT alternative solutions to the
same problem, but solutions to two problems.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

