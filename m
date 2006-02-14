Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030320AbWBNEgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbWBNEgz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 23:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030340AbWBNEgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 23:36:55 -0500
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:61520 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S1030320AbWBNEgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 23:36:55 -0500
Message-ID: <43F15E65.4090102@bigpond.net.au>
Date: Tue, 14 Feb 2006 15:36:53 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Gruenbacher <agruen@suse.de>
CC: quilt-dev@nongnu.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Quilt-dev] Quilt 0.43 has been released! [SERIOUS BUG]
References: <20060202230210.05a6ad4a.khali@linux-fr.org> <43F14DAA.6000703@bigpond.net.au> <200602140510.54960.agruen@suse.de>
In-Reply-To: <200602140510.54960.agruen@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Tue, 14 Feb 2006 04:36:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Gruenbacher wrote:
> On Tuesday 14 February 2006 04:25, Peter Williams wrote:
> 
>>The problem arises when pushing a patch that has errors in it (due to
>>changes in the previous patches in the series) and needs the -f flag to
>>force the push.  What's happening is that the reverse of the errors is
>>being applied to the "pre patch" file in the .pc directory.  Then when
>>you pop this patch it returns the file to a state with the reverse of
>>the errors applied to it.
> 
> 
> Found and fixed. It's a missed rollback_patch on one of the two branches of 
> the code that checks if a patch can be reverse applied.

That was quick.

> This case apparently 
> doesn't trigger as easily as it seems, or else we would have found it sooner. 
> Still quite bad.
> 
> Shall we wait until the translations are up-to-date again, or release 0.44 
> immediately?
> 
> 
>>I'm having trouble understanding how quilt could be dumb enough to do
>>this as surely the "pre patch" file in the .pc directory should be just
>>a copy of the file before the patch is applied.
> 
> 
> Hey, it's just a bug.

:-)

> 
> 
>>This bug can completely hose a set of patches if the user doesn't notice
>>it very early and do something about it.  The work around is to revert
>>to version 0.42 of quilt.
> 
> 
> You should have sent your gquilt announcement to the quilt-dev list as well. 
> Thank you for summarizing the changes.

Sorry.  They were mainly due to your change from "-p <patch>" to "-P 
<patch>" for some commands.  The other issue was a change to the return 
value and error message when "quilt top" was used in a directory without 
any quilt data.  So no real changes to gquilt as seen by the user just 
implementation changes.

BTW the --version function made it possible to make gquilt still work 
with versions earlier than 0.43.

Thanks
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
