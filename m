Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUBVW55 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 17:57:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbUBVW54
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 17:57:56 -0500
Received: from mail.shareable.org ([81.29.64.88]:13442 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261162AbUBVW5z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 17:57:55 -0500
Date: Sun, 22 Feb 2004 22:57:50 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Paul Jackson <pj@sgi.com>
Cc: Hansjoerg Lipp <hjlipp@web.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-ID: <20040222225750.GA27402@mail.shareable.org>
References: <20040216133418.GA4399@hobbes> <20040222020911.2c8ea5c6.pj@sgi.com> <20040222155410.GA3051@hobbes> <20040222125312.11749dfd.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040222125312.11749dfd.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> > BTW, which shell expects the name of the script in argv[2]?
> 
> Which ones don't?

I believe the question was "which shell expects the name in argv[2]
regardless of an options given before the name".

That rules out all the ordinary shell programs.

> The burden is on you, not me. The Bourne like shells
> that I happen to try just now _do_ display syntax error messages in
> shell scripts with the name of the shell script file in the error
> message.  Look and see how they are getting that script file name.

The standard shell programs all get the name from the first non-option
argument.

> What's theoretical on one persons machine is very real and painful
> on a million persons machines.  Incompatible changes in documented
> interfaces have a high threshold to overcome.

I'll be astonished if the change to split the arguments breaks any
script which actually exists, except for the rare and convoluted
possibility: where the interpreter is a C program specially written to
workaround the fact that Linux doesn't split the arguments.

The backslash functionality (\t) may be more of a problem.

-- Jamie
