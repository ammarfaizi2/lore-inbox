Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbVCFRLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbVCFRLh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 12:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVCFRLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 12:11:36 -0500
Received: from main.gmane.org ([80.91.229.2]:58581 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261438AbVCFRLd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 12:11:33 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andres Salomon <dilinger@voxel.net>
Subject: Re: [RFQ] Rules for accepting patches into the linux-releases tree
Date: Sun, 06 Mar 2005 12:10:43 -0500
Message-ID: <pan.2005.03.06.17.10.41.114607@voxel.net>
References: <20050304222146.GA1686@kroah.com> <20050305104305.GB7671@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cpe-24-194-62-26.nycap.res.rr.com
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner-SpamScore: ss
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Mar 2005 11:43:05 +0100, Andries Brouwer wrote:

> On Fri, Mar 04, 2005 at 02:21:46PM -0800, Greg KH wrote:
> 
>> Anything else anyone can think of?  Any objections to any of these?
>> I based them off of Linus's original list.
>> 
>> thanks,
>> 
>> greg k-h
>> 
>> ------
>> 
>> Rules on what kind of patches are accepted, and what ones are not, into
>> the "linux-release" tree.
>> 
>>  - It can not bigger than 100 lines, with context.
>>  - It must fix only one thing.
>>  - It must fix a real bug that bothers people (not a, "This could be a
>>    problem..." type thing.)

An obvious fix is an obvious fix.  It shouldn't matter whether people have
triggered a bug or not; why discriminate?

>>  - It must fix a problem that causes a build
error (but not for things
>>    marked CONFIG_BROKEN), an oops, a hang, or a real security issue.
>>  - No "theoretical race condition" issues, unless an explanation of how
>>    the race can be exploited.

I disagree w/ this; if it's an obvious fix, there should be no need for
this.  Either it's a race that is clearly incorrect (after tracing through
the relevant code), or it's not.

>>  - It can not contain any "trivial" fixes in it (spelling changes,
>>    whitespace cleanups, etc.)

This and the "it must fix a problem" are basically saying the same thing.

> 
> Objections - no. Anything else - yes. I would like the requirement: "It
> must be obviously correct".
> 

It seems like this would be the primary thing that matters.  The rest of
them (aside from the "fixes only one thing" and "no cleanups" rules)
overlap considerably.  
 
> In a hundred lines one can put a lot of tricky code and subtle
changes.
> For example, if a security problem necessitates a nontrivial change, it
> should cause an earlier release of 2.6.x+1 instead of a 2.6.x.y+1.
> 
> Andries


