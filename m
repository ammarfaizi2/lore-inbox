Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbUBWU10 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 15:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbUBWU10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 15:27:26 -0500
Received: from imap.gmx.net ([213.165.64.20]:2790 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262029AbUBWU1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 15:27:24 -0500
X-Authenticated: #20799612
Date: Mon, 23 Feb 2004 21:13:40 +0100
From: Hansjoerg Lipp <hjlipp@web.de>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Linux 2.6: shebang handling in fs/binfmt_script.c
Message-ID: <20040223201340.GA13914@hobbes>
References: <20040216133418.GA4399@hobbes> <20040222020911.2c8ea5c6.pj@sgi.com> <20040222155410.GA3051@hobbes> <20040222125312.11749dfd.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040222125312.11749dfd.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 22, 2004 at 12:53:12PM -0800, Paul Jackson wrote:
> > BTW, which shell expects the name of the script in argv[2]?
> 
> Which ones don't?  The burden is on you, not me. The Bourne like shells
> that I happen to try just now _do_ display syntax error messages in
> shell scripts with the name of the shell script file in the error
> message.  Look and see how they are getting that script file name.

Although I still don't think, this is relevant (because scripts for
interpreters having these problems don't have to pass multiple arguments
on the shebang line), I just tested some example scripts like this:
  ----
#!/bin/zsh -v -x
echo "argv0: $0"
/foo/bar
  ----
(the last line to get an error message).
Everything works as expected using those shells:
  ksh:      PD KSH v5.2.14
  GNU bash: 2.05b
  ash:      0.2
  zsh:      4.1.1
  tcsh:     6.12.00

I could have a look at the sources, but as this is the behaviour the man
pages and susv3 describe, this should be "evidence" enough(?).

Regards,

	Hansjoerg Lipp
