Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266590AbUGPW1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266590AbUGPW1i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 18:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266627AbUGPW1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 18:27:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:40906 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266590AbUGPW1g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 18:27:36 -0400
Date: Fri, 16 Jul 2004 15:27:33 -0700 (PDT)
From: Bryce Harrington <bryce@osdl.org>
To: Paul Larson <plars@linuxtestproject.org>
cc: <ltp-list@lists.sourceforge.net>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [LTP] LTP Results - July 15, 2004
In-Reply-To: <1089990640.3151.108.camel@plars.austin.ibm.com>
Message-ID: <Pine.LNX.4.33.0407161507340.15956-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2004, Paul Larson wrote:

> On Thu, 2004-07-15 at 22:42, Bryce Harrington wrote:
> > (Sorry, this time _with_ a subject line)
> >
> > LTP version LTP-20040506:
> >
> > Patch Name           TestReq#     CPU  PASS  FAIL  WARN  BROK  RunTime
> > ----------------------------------------------------------------------
> > 2.6.7-mm7              294831  2-way  7184    45     3     6    44.0
> These are clearly not valid failures.  How are you running ltp?  Any
> chance you are running out of disk space in /tmp?

Daniel McNeil and Mark Haverkamp investigated it and found it to be a
valid failure:

    http://lkml.org/lkml/2004/7/12/227

We were able to reliably recreate it both in and out of the STP
framework, on a variety of systems, with both the May and July versions
of LTP.  We were able to trace it to a specific patch that was
introduced via 2.6.7-mm1 and that began affecting the bk tree as of
2.6.7-bk-11 a week later.

Further, I've just learned that Daniel has developed a patch which fixes
this issue:

    http://www.osdl.org/plm-cgi/plm?module=patch_info&patch_id=3168

Here is the test result showing in the test framework demonstrating
that the patch fixes the issue:

    Summary of Test Results Total Tests Executed: 7242
    Number Tests Passed: 7230
    Number Tests Failed: 3
    Number Tests Warnings: 3
    Number Tests Broken: 6

    http://khack.osdl.org/stp/295150/

Thanks,
Bryce


