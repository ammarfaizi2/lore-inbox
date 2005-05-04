Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVEDRvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVEDRvu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 13:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261175AbVEDRvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:51:49 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:14480 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261165AbVEDRve
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:51:34 -0400
Message-ID: <42790B8A.9010406@tmr.com>
Date: Wed, 04 May 2005 13:51:06 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
CC: Matt Mackall <mpm@selenic.com>,
       "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>,
       Linus Torvalds <torvalds@osdl.org>, Ryan Anderson <ryan@michonline.com>,
       Andrea Arcangeli <andrea@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
References: <4277A52E.1020601@tmr.com><4277A52E.1020601@tmr.com> <4277B15F.1020102@lsrfire.ath.cx>
In-Reply-To: <4277B15F.1020102@lsrfire.ath.cx>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rene Scharfe wrote:
> Bill Davidsen schrieb:
> 
>>On the theory that my first post got lost, why use /usr/bin/env at 
>>all, when bash already does that substitution? To support people who 
>>use other shells?
>>
>>ie.: FOO=xx perl -e '$a=$ENV{FOO}; print "$a\n"'
> 
> 
> /usr/bin/env is used in scripts in the shebang line (the very first line
> of the script, starting with "#!", which denotes the interpreter to use
> for that script) to make a PATH search for the real interpreter.
> Some folks keep their python (or Perl, or Bash etc.) in /usr/local/bin
> or in $HOME, that's why this construct is needed at all.
> 
> Changing environment variables is not the goal, insofar this usage
> exploits only a side-effect of env.  It is portable in practice because
> env is in /usr/bin on most modern systems.
> 
> So you could replace this first line of a bash script:
> 
>    #!/usr/bin/env python
> 
> with this:
> 
>    #!python
> 
> except that the latter doesn't work because you need to specify an
> absolute path there. :]

Assuming that you want the PATH search rather than a symlink in 
/usr/bin, of course. This opens the door to forgetting you just loaded 
the CVS daily of python into your test directory and doing an unplanned 
test of alpha software, but if people think the application should work 
with non-standard tool chains, and realize it has possible unwanted 
effects, that's a design decision.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
