Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262406AbTCMP1g>; Thu, 13 Mar 2003 10:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262408AbTCMP1f>; Thu, 13 Mar 2003 10:27:35 -0500
Received: from ns0.cobite.com ([208.222.80.10]:3079 "EHLO ns0.cobite.com")
	by vger.kernel.org with ESMTP id <S262406AbTCMP1e>;
	Thu, 13 Mar 2003 10:27:34 -0500
Date: Thu, 13 Mar 2003 10:38:19 -0500 (EST)
From: David Mansfield <lkml@dm.cobite.com>
X-X-Sender: david@admin
To: Larry McVoy <lm@bitmover.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <Pine.LNX.4.44.0303131026380.7061-100000@admin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Larry,

I've been reading this thread, and I think the CVS repository you set up 
is a great service.  I have a request to improve the quality of the data.

If you want to skip straight to the suggestion, goto SUGGESTION.

I am maintainer of a handy GPLed utility called 'cvsps' (plug:  
http://www.cobite.com/cvsps) which extracts 'patchset' information from a
cvs repository by parsing the 'cvs log' output. It attempts to recreate a
commit as a single atomic action, and all the branch and tag gook that
goes with it.

It's a read-only tool that I find useful to see what is going on in a cvs 
repository.

Back to you: I've looked at the CVS log output from your repository, and
had my program parse it back into 'patchsets' but it's not doing a great
job because the log messages from separate parts of the commit are
different.

This is fine, because I can easily write a 'hack' to look explicitly for 
the '(Logical change x.yyyyy)' text to group individual file commits back 
into patchsets.

But this text is missing from the 'main' file commit (to the ChangeSet
file) that has the BKrev: tag in it.

SUGGESTION:
Put the '(Logical change x.yyyy)' text into EVERY log message that is a 
port of the logical change, including the 'main' commit to the ChangeSet, 
that commit has the BKrev: in it (it's missing from this one file's log 
message).

Then I can make a '--bk' hack to my program to use this 'key' to recreate 
the commits.

Let me know what you think,
David

-- 
/==============================\
| David Mansfield              |
| lkml@dm.cobite.com           |
\==============================/

