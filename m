Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbUBDHmB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 02:42:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266307AbUBDHmB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 02:42:01 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:52426 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S266304AbUBDHl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 02:41:59 -0500
Date: Tue, 3 Feb 2004 23:44:27 -0800
From: Paul Jackson <pj@sgi.com>
To: Glen Turner <glen.turner@aarnet.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: User-space notification of process end
Message-Id: <20040203234427.112ed823.pj@sgi.com>
In-Reply-To: <1075780082.6747.23.camel@andromache>
References: <1075780082.6747.23.camel@andromache>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am writing a application which needs to know fairly promptly if a
> daemon has died.  I'd prefer not to ... run the program as a non-daemon
> child of a daemon watcher process.

Why not a watcher process, if I may ask.  That is, I'd be tempted to
stash a copy of the daemon's executable, and in place of the original
executalbe put a piece of code that fork/exec'd the stashed copy, waited
for the exit, and notified you as need be.

The available operations on files in the /proc file system tend to
be a very limited subset of those on regular files; so I am not
surprised that F_NOTIFY didn't work.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
