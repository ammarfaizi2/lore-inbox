Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130325AbRCETPU>; Mon, 5 Mar 2001 14:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130329AbRCETPK>; Mon, 5 Mar 2001 14:15:10 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:6741 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S130325AbRCETOx>; Mon, 5 Mar 2001 14:14:53 -0500
Date: Mon, 5 Mar 2001 13:14:25 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200103051914.NAA63254@tomcat.admin.navo.hpc.mil>
To: kodis@mail630.gsfc.nasa.gov,
        "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: binfmt_script and ^M
Cc: linux-kernel@vger.kernel.org, bug-bash@gnu.org
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Kodis <kodis@mail630.gsfc.nasa.gov>:
> On Mon, Mar 05, 2001 at 08:40:22AM -0500, Richard B. Johnson wrote:
> 
> > Somebody must have missed the boat entirely. Unix does not, never
> > has, and never will end a text line with '\r'.
> 
> Unix does not, never has, and never will end a text line with ' ' (a
> space character) or with \t (a tab character).  Yet if I begin a shell
> script with '#!/bin/sh ' or '#!/bin/sh\t', the training white space is
> striped and /bin/sh gets exec'd.  Since \r has no special significance
> to Unix, I'd expect it to be treated the same as any other whitespace
> character -- it should be striped, and /bin/sh should get exec'd.

Actually it does have some significance - it causes a return, then the
following text overwrites the current text. Granted, this is only used
occasionally for generating bold/underline/... 

This is used in some formatters (troff) occasionally, though it tends to
use backspace now.

\r is not considered whitespace, though it should be possible to define
it that way. A line terminator is always \n.

Another point, is that the "#!/bin/sh" can have options added: it can be
"#!/bin/sh -vx" and the option -vx is passed to the shell. The space is
not just "stripped". It is used as a parameter separator. As such, the
"stripping" is only because the first parameter is separated from the
command by whitespace.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
