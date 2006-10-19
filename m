Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946652AbWJSXJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946652AbWJSXJV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 19:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946654AbWJSXJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 19:09:21 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:62618 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1946652AbWJSXJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 19:09:20 -0400
Date: Thu, 19 Oct 2006 16:09:00 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Nick Piggin <npiggin@suse.de>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, akpm@osdl.org
Subject: Re: + fs-prepare_write-fixes.patch added to -mm tree
Message-ID: <20061019230900.GE10128@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <200610182150.k9ILoLNk019702@shell0.pdx.osdl.net> <20061019014209.GA10128@ca-server1.us.oracle.com> <20061019052537.GA15687@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061019052537.GA15687@wotan.suse.de>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2006 at 07:25:37AM +0200, Nick Piggin wrote:
> I sent an RFC to linux-fsdevel, did you get that?
Yeah, I don't think I thought of my concerns at the time.


> I was planning to cc some maintainers, including you, for those
> filesystems that are non-trivial. I just hadn't had a chance to
> test it properly last night.
Cool, I appreciate that.


> OK thanks for looking at that. If the length of the commit is greater
> than 0 (but still short), then the page is uptodate so it should be
> fine to commit what we have written, I think?
That seems to make sense to me.

 
> If the length is zero, then we probably want to roll back entirely.
The thing is, rollback might be hard (or expensive) for some file systems
with more complicated tree implementations, etc.

Do we have the option in this case of just zeroing the newly allocated
portions and writing them out? Userspace would then just be seeing
that like any other hole.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
