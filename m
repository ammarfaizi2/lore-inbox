Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbUBXB01 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 20:26:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbUBXBQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 20:16:36 -0500
Received: from pop.gmx.de ([213.165.64.20]:60330 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262162AbUBXBNx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 20:13:53 -0500
X-Authenticated: #20799612
Date: Tue, 24 Feb 2004 01:21:24 +0100
From: Hansjoerg Lipp <hjlipp@web.de>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-ID: <20040224002124.GB6426@hobbes>
References: <20040216133418.GA4399@hobbes> <20040222020911.2c8ea5c6.pj@sgi.com> <20040222155410.GA3051@hobbes> <20040222125312.11749dfd.pj@sgi.com> <20040223201340.GA13914@hobbes> <20040223142451.1432ef52.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040223142451.1432ef52.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 02:24:51PM -0800, Paul Jackson wrote:
> Hansjoerg wrote:
> > #!/bin/zsh -v -x
> > ...
> > this should be "evidence" enough(?)
> 
> This testing was done on a system with your patch applied, right?

Yes. The results are the same if you use a stock kernel and call the
script manually.

> Because on a stock kernel, the various shells are of course
> confused by the "-v -x" argv[1].

Yes, of course.

> I will grant that ksh, bash, ash, tcsh and zsh are likely ok
> (willing to see > 1 option before the script file name.)
> 
> An alternative way to test the same thing, that works even on
> a stock kernel:
> 
>   $ echo 'echo "$*"' > ./d
>   $ ash -e -e ./d 1 2 3
>   $ tcsh -v -v ./d 1 2 3
>   $ zsh -e -e ./d 1 2 3
>   $ ksh -e -e ./d 1 2 3
>   $ bash -e -e ./d 1 2 3
> 
> The thing being tested: will a shell handle > 1 option before a script
> file name.  Each shell invocation of the "./d" script should echo the
> script file arguments "1 2 3".

This works as expected.

Regards,

	Hansjoerg Lipp
