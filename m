Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268947AbUHMCev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268947AbUHMCev (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 22:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268948AbUHMCev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 22:34:51 -0400
Received: from gherkin.frus.com ([192.158.254.49]:32994 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S268947AbUHMCet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 22:34:49 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
In-Reply-To: <cfgpa6$gu2$1@gatekeeper.tmr.com> "from Bill Davidsen at Aug 12,
 2004 06:10:21 pm"
To: Bill Davidsen <davidsen@tmr.com>
Date: Thu, 12 Aug 2004 21:34:48 -0500 (CDT)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20040813023448.62CD8DBDD@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> David Woodhouse wrote:
> > On Mon, 2004-08-09 at 16:12 +0200, Joerg Schilling wrote:
> > 
> >>If you are right, why then is SuSE removing the warnings in cdrecord
> >>that are there to tell the user that cdrecord is running with insufficient 
> >>privilleges?
> > 
> > 
> > Because those warnings are bogus, put there by someone who likes to
> > complain about things that are not _really_ a problem?
> 
> Actually they are a problem on a loaded system, it's just that 
> developers seem to run system with enough power to avoid the issues. And 
> if you have a system using burn-free all the time you do use more track 
> and the occasional device won't read it.

Another possible reason for removing the warnings (which I encountered
while trying out the latest xcdroast today): any output to stderr during
the burn is flagged by the wrapper as an error, which violates the
principle of least astonishment from a user perspective.  In other words,
no distinction is made between warnings and errors before announcing an
error has occurred.

Understanding this, it's easy enough to scan the expanded output and see
what really happened.  FWIW, I don't think removing the warnings to avoid
this issue is the correct solution.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
